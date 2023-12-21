import 'package:flutter/material.dart';

class ButtonSendChat extends StatelessWidget {
  const ButtonSendChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blue[700],
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.send_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
