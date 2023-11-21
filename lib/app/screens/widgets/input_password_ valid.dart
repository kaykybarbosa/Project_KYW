import 'package:flutter/cupertino.dart';

class InputPasswordValid extends StatelessWidget {
  const InputPasswordValid({super.key, required this.placeHolder});

  final String placeHolder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CupertinoTextFormFieldRow(
          obscureText: true,
          placeholder: 'Senha',
          placeholderStyle: const TextStyle(
              fontSize: 20, color: CupertinoColors.placeholderText),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(width: 2, color: CupertinoColors.inactiveGray)),
          validator: (password) {
            if (password == null || password.isEmpty) {
              return 'Digite uma senha válida';
            } else if (password.length < 6) {
              return 'A senha deve conter 6 caracteres.';
            } else {
              return null;
            }
          }),
    );
  }
}
