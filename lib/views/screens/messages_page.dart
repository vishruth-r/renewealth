import 'package:flutter/material.dart';

class Chat {
  final String name;
  final String lastMessage;
  final String profileImageUrl;

  Chat({required this.name, required this.lastMessage, required this.profileImageUrl});
}

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Chat> chats = [
    Chat(name: 'User 1', lastMessage: 'Hello', profileImageUrl: 'https://example.com/image1.png'),
    Chat(name: 'User 2', lastMessage: 'Hi', profileImageUrl: 'https://example.com/image2.png'),
    // Add more chats here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ChatSearch(chats));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chats[index].profileImageUrl),
            ),
            title: Text(chats[index].name),
            subtitle: Text(chats[index].lastMessage),
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
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
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