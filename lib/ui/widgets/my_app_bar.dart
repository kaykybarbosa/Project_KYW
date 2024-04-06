import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.text, required this.onTap});

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: CupertinoColors.white,
        ),
        onPressed: () {
          onTap();
        },
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 25.0,
          color: CupertinoColors.white,
        ),
      ),
      backgroundColor: CupertinoTheme.of(context).primaryColor,
    );
  }
}
