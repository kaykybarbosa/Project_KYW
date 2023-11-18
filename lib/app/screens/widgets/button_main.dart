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
    return CupertinoButton(
      onPressed: () => widget.onTap(),
      child: SizedBox(
        height: 50,
        width: 350,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: const Color.fromRGBO(50, 58, 71, 1), width: 2),
              color: const Color.fromRGBO(50, 58, 71, 1)),
          child: Text(
            widget.text,
            style: const TextStyle(color: CupertinoColors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
