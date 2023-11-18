import 'package:flutter/cupertino.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key, required this.placeHolder, this.isPassword = false});

  final String placeHolder;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: CupertinoTextField(
        padding: const EdgeInsets.all(10),
        obscureText: isPassword,
        placeholderStyle:
            const TextStyle(color: CupertinoColors.placeholderText),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey2, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        placeholder: placeHolder,
      ),
    );
  }
}
