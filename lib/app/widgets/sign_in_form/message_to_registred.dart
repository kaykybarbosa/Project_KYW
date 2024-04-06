import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/services/routers/my_routes.dart';

class MessageToRegistered extends StatelessWidget {
  const MessageToRegistered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle defaultText = const TextStyle(color: Colors.black, fontSize: 16);
    TextStyle linkText = const TextStyle(color: Colors.blue, fontSize: 16);

    return SizedBox(
      width: 260,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Não possui uma conta? ',
              style: defaultText,
            ),
            TextSpan(
              text: 'Clique aqui ',
              style: linkText,
              recognizer: TapGestureRecognizer()..onTap = () => GoRouter.of(context).push(AppRoutes.signUp),
            ),
            TextSpan(
              text: 'para criar uma',
              style: defaultText,
            ),
          ],
        ),
      ),
    );
  }
}
