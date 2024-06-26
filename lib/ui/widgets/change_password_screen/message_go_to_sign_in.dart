import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';

class MessageGoToSignIn extends StatelessWidget {
  const MessageGoToSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle defaultText = const TextStyle(color: Colors.black, fontSize: 16);
    TextStyle linkText = const TextStyle(color: Colors.blue, fontSize: 16);

    return SizedBox(
      width: 230,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Clique aqui ',
              style: linkText,
              recognizer: TapGestureRecognizer()..onTap = () => Get.offAllNamed(AppRoutes.signIn),
            ),
            TextSpan(text: 'para realizar o login', style: defaultText),
          ],
        ),
      ),
    );
  }
}
