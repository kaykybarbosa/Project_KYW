import 'package:flutter/cupertino.dart';

class AccountInput extends StatelessWidget {
  const AccountInput(
      {super.key, required this.placeHolder, required this.validator});

  final String placeHolder;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border.all(color: CupertinoColors.systemBlue),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: CupertinoColors.systemBlue,
            blurRadius: 1.5,
            spreadRadius: 0.5,
          ),
        ],
      ),
      placeholder: placeHolder,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
