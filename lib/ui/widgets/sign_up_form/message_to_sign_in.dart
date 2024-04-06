import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/services/routers/my_routes.dart';

class MessageToSignIn extends StatelessWidget {
  const MessageToSignIn({super.key});

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
              recognizer: TapGestureRecognizer()..onTap = () => GoRouter.of(context).pushReplacement(AppRoutes.signIn),
            ),
            TextSpan(text: 'para realizar o login', style: defaultText),
          ],
        ),
      ),
    );
  }
}
