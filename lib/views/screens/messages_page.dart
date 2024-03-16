import 'package:flutter/material.dart';

import 'chat_page.dart';

class Chat {
  final String name;
  final String lastMessage;
  final String profileImageUrl;
  Chat({required this.name, required this.lastMessage, required this.profileImageUrl});
}

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Chat> chats = [
    Chat(name: 'Vishruth', lastMessage: 'Ofcourse', profileImageUrl: 'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'),
    Chat(name: 'Anirudh', lastMessage: 'Hey, I wanted some more info about the listing', profileImageUrl: 'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ChatSearch(chats));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    recipientName: chats[index].name,
                    recipientImageUrl: chats[index].profileImageUrl,
                  ),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(chats[index].profileImageUrl),
              ),
              title: Text(chats[index].name),
              subtitle: Text(chats[index].lastMessage),
            ),
          );
        },
      ),
    );
  }
}

class ChatSearch extends SearchDelegate<Chat> {
  final List<Chat> chats;

  ChatSearch(this.chats);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          FocusScope.of(context).unfocus(); // Close the keyboard
          close(context, Chat(name: '', lastMessage: '', profileImageUrl: '')); // Close the search
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {

      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? chats
        : chats.where((chat) => chat.name.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(suggestions[index].profileImageUrl),
          ),
          title: Text(suggestions[index].name),
          subtitle: Text(suggestions[index].lastMessage),
          onTap: () {
            close(context, suggestions[index]);
          },
        );
      },
    );
  }
}