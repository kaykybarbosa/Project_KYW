import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateProjectButton extends StatelessWidget {
  const CreateProjectButton({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onTap(),
      backgroundColor: CupertinoColors.activeBlue,
      child: const Icon(
        CupertinoIcons.add,
        size: 30.0,
        color: CupertinoColors.white,
      ),
    );
  }
}
