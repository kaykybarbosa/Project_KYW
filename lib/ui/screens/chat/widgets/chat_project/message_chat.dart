import 'package:flutter/material.dart';
import 'package:kyw_management/utils/formaters.dart';

import '../../../../../domain/models/message_model.dart';

class MessageChat extends StatelessWidget {
  const MessageChat({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: false ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.only(
        right: false ? 8 : 75,
        left: false ? 75 : 8,
        top: 5,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 7,
          bottom: 7,
          left: false ? 10 : 15,
          right: false ? 15 : 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[350],
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.only(
            topLeft: false ? Radius.circular(10) : Radius.zero,
            topRight: false ? Radius.zero : Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User name
            Visibility(
              visible: !false,
              child: Text(
                message.content,
                style: const TextStyle(
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
                    '${message.content}           ',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    Formaters.formatDate(message.sendIn),
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
