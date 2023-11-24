import 'package:flutter/cupertino.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator(
      {super.key,
      required this.title,
      required this.onTap,
      this.wasPressed = true,
      this.borderColor = CupertinoColors.white});

  final String title;
  final Function onTap;
  final bool wasPressed;
  final Color borderColor;

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        alignment: Alignment.topCenter,
        width: 100,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 2,
                color: widget.wasPressed
                    ? CupertinoColors.white
                    : CupertinoTheme.of(context).primaryColor),
          ),
        ),
        child: Text(widget.title,
            style: const TextStyle(color: CupertinoColors.white, fontSize: 18)),
      ),
    );
  }
}
