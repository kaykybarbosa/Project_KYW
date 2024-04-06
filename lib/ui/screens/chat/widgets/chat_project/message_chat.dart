import 'package:flutter/material.dart';

import '../../../../../domain/models/message_model.dart';

class MessageChat extends StatelessWidget {
  const MessageChat({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: message.isSender ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        right: message.isSender ? 8 : 75,
        left: message.isSender ? 75 : 8,
        top: 5,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 7,
          bottom: 7,
          left: message.isSender ? 10 : 15,
          right: message.isSender ? 15 : 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[350],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
            topLeft: message.isSender ? const Radius.circular(10) : Radius.zero,
            topRight: message.isSender ? Radius.zero : const Radius.circular(10),
            bottomLeft: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User name
            Visibility(
              visible: !message.isSender,
              child: Text(
                message.userReference,
                style: TextStyle(
                  color: message.nameColor,
                  fontSize: 17,
                ),
              ),
            ),
            // Message send
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '${message.message}           ',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    message.dateSend,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
