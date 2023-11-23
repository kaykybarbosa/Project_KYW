import 'package:flutter/cupertino.dart';

class ButtonMain extends StatefulWidget {
  const ButtonMain({super.key, required this.text, required this.onTap});

  final String text;
  final Function onTap;

  @override
  State<ButtonMain> createState() => _ButtonMainState();
}

class _ButtonMainState extends State<ButtonMain> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: () => widget.onTap(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CupertinoTheme.of(context).primaryColor),
        child: Text(
          widget.text,
          style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
