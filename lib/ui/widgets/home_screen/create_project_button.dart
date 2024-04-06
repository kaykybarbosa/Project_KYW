import 'package:flutter/material.dart';

class CreateProjectButton extends StatelessWidget {
  const CreateProjectButton({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onTap(),
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.add,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
