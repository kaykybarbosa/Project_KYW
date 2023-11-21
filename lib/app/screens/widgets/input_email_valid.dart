import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class InputEmailValid extends StatelessWidget {
  const InputEmailValid({super.key, required this.placeHolder});

  final String placeHolder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CupertinoTextFormFieldRow(
          textInputAction: TextInputAction.next,
          placeholder: placeHolder,
          placeholderStyle: const TextStyle(
              fontSize: 20, color: CupertinoColors.placeholderText),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: CupertinoColors.inactiveGray),
          ),
          validator: (email) => email != null && !EmailValidator.validate(email)
              ? 'Digite um e-mail válido'
              : null),
    );
  }
}
