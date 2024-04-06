import 'package:flutter/material.dart';

class MessageInputChat extends StatelessWidget {
  const MessageInputChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SearchBar(
        backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
        hintText: 'Mensagem',
        trailing: [
          Transform.rotate(
            angle: 0.5,
            child: const Icon(Icons.attach_file_rounded),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 5),
            child: Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
