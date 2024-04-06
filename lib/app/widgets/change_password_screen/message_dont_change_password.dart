import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/domain/services/routers/my_routes.dart';

class MessageDontCreatePassword extends StatelessWidget {
  const MessageDontCreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
      color: Colors.black,
      fontSize: 16,
    );

    const TextStyle styleLink = TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return SizedBox(
      width: 220,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Clique aqui',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Go to HomeApp
                  GoRouter.of(context).go(AppRoutes.signIn);
                },
              style: styleLink,
            ),
            const TextSpan(
              text: ' se você não deseja criar uma nova senha',
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
