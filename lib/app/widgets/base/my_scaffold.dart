import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold(
      {super.key,
      required this.arrowBack,
      required this.title,
      required this.body});

  final Function arrowBack;
  final String title;
  final Widget body;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoTheme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            widget.arrowBack();
          },
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: CupertinoColors.white),
        ),
      ),
      body: widget.body,
    );
  }
}
