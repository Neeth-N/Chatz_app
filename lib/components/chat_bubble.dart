import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({super.key, required this.isCurrentUser, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Text(message, style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.inversePrimary),),
    );
  }
}
