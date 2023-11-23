import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';

class InputEmailValid extends StatelessWidget {
  const InputEmailValid({super.key, required this.placeHolder});

  final String placeHolder;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      padding: EdgeInsets.zero,
      placeholder: placeHolder,
      style: MyDecorations.inputTextStyle(),
      placeholderStyle: MyDecorations.placeHolderStyle(),
      decoration: MyDecorations.inputDecoration(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) {
        if (email != null && !EmailValidator.validate(email)) {
          return 'Digite um e-mail válido';
        }

        return null;
      },
    );
  }
}
