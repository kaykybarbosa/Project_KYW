import 'package:flutter/material.dart';

import '../../../domain/services/app_routes/export_routes.dart';

class ForgotToGoSignIn extends StatelessWidget {
  const ForgotToGoSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle defaultText = const TextStyle(color: Colors.black, fontSize: 16);
    TextStyle linkText = const TextStyle(color: Colors.blue, fontSize: 16);
    return SizedBox(
      width: 240,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'Possui uma conta? ', style: defaultText),
            TextSpan(
              text: 'Clique aqui ',
              style: linkText,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  GoRouter.of(context).pushReplacement(MyRoutes.signIn);
                },
            ),
            TextSpan(text: 'para realizar o login', style: defaultText),
          ],
        ),
      ),
    );
  }
}
