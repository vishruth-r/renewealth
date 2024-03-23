import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  final String otherPersonName;

  ChatPage({Key? key, required this.otherPersonName}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<Chat>> futureChats;
  TextEditingController _messageController = TextEditingController();
  late String personId;
  late String otherPersonId;
  late String otherPersonName;

  @override
  void initState() {
    super.initState();
    futureChats = fetchChats();
    personId = ""; // Initialize with empty string
    otherPersonId = ""; // Initialize with empty string
    otherPersonName = "Srinivasan"; // Initialize with empty string
    _fetchChatMetadata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(otherPersonName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/whatsapp.png'), // Your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Chat>>(
                future: futureChats,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Chat> sortedChats = snapshot.data!;
                    sortedChats.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Sort in descending order
                    return ListView.builder(
                      itemCount: sortedChats.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return _buildChatBubble(sortedChats[index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(Chat chat) {
    bool isSentByPerson = chat.senderId == personId;
    return Align(
      alignment: isSentByPerson ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSentByPerson ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat.message,
              style: TextStyle(
                color: isSentByPerson ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              _formatDateTime(chat.createdAt),
              style: TextStyle(
                color: isSentByPerson ? Colors.white70 : Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage(_messageController.text);
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _fetchChatMetadata() async {
    final response = await http.get(Uri.parse('https://e8a2-2409-40f4-9-507f-d94f-ab52-653d-afde.ngrok-free.app/chats/d903d940-5195-4767-823c-398897b43783/chats/981aef57-c535-483d-9b20-e833fff93a72')); // Replace 'YOUR_API_ENDPOINT' with actual API URL
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      personId = data['person']['id']; // Set personId from API response
      otherPersonId = data['otherPerson']['id']; // Set otherPersonId from API response
      otherPersonName = data['otherPerson']['name']; // Set otherPersonName from API response
    } else {
      throw Exception('Failed to load chat metadata');
    }
  }

  Future<List<Chat>> fetchChats() async {
    final response = await http.get(Uri.parse('https://e8a2-2409-40f4-9-507f-d94f-ab52-653d-afde.ngrok-free.app/chats/d903d940-5195-4767-823c-398897b43783/chats/981aef57-c535-483d-9b20-e833fff93a72')); // Replace 'YOUR_API_ENDPOINT' with actual API URL
    if (response.statusCode == 200) {
      final List<dynamic> chatData = jsonDecode(response.body)['chats'];
      return chatData.map((json) => Chat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chats');
    }
  }

  void _sendMessage(String message) async {
    final Map<String, dynamic> messageData = {
      "receiverId": otherPersonId,
      "senderId": personId,
      "message": message,
    };

    final response = await http.post(
      Uri.parse('https://e8a2-2409-40f4-9-507f-d94f-ab52-653d-afde.ngrok-free.app/chats/send'), // Replace 'YOUR_POST_ENDPOINT' with actual API URL for sending messages
      body: jsonEncode(messageData),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      // If message sent successfully, refresh the chat list
      setState(() {
        futureChats = fetchChats();
      });
    } else {
      // Handle error
      print('Failed to send message: ${response.body}');
    }
  }

  _formatDateTime(DateTime dateTime) {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // Ensures time is always in HH:MM format
  }
}

class Chat {
  final String id;
  final String message;
  final String receiverId;
  final String senderId;
  final DateTime createdAt;

  Chat({
    required this.id,
    required this.message,
    required this.receiverId,
    required this.senderId,
    required this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      message: json['message'],
      receiverId: json['receiverId'],
      senderId: json['senderId'],
      createdAt: DateTime.parse(json['createdAt']).add(Duration(hours: 5,minutes: 30)), // Add 30 minutes to each message time
    );
  }
}