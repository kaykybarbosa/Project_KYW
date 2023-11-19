import 'package:flutter/cupertino.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.placeHolder,
      this.isPassword = false,
      this.validation});

  final String placeHolder;
  final bool isPassword;
  final Function? validation;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: const EdgeInsets.all(10),
      obscureText: widget.isPassword,
      placeholderStyle: const TextStyle(color: CupertinoColors.placeholderText),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey2, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      placeholder: widget.placeHolder,
      onChanged: (value) => widget.validation,
    );
  }
}
