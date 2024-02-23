import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatPage extends StatelessWidget {
  final String recipientName;
  final String recipientImageUrl;

  const ChatPage({Key? key, required this.recipientName, required this.recipientImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(recipientImageUrl),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(
              recipientName,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/bg.svg',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    MessageBubble(
                      message: 'Hey, how are you? Could you tell me a little more about your listing',
                      isSentByMe: true,
                      time: DateTime.now(),
                    ),
                    MessageBubble(
                      message: 'I\'m good, thanks! Yeah we could get on a call at 8 tonight. I\'ll send you the details.',
                      isSentByMe: false,
                      time: DateTime.now(),
                    ),
                    MessageBubble(
                      message: 'That would be great, thanks!',
                      isSentByMe: true,
                      time: DateTime.now(),
                    ),
                    MessageBubble(
                      message: 'Ofcourse see you at 8.',
                      isSentByMe: false,
                      time: DateTime.now(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final DateTime time;

  const MessageBubble({super.key, required this.message, required this.isSentByMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black,
              ),
            ),
            Text(
              '${time.hour}:${time.minute}',
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}