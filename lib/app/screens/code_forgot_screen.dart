import 'package:flutter/material.dart';
import 'package:kyw_management/app/widgets/forgot_password_screens/code_input_forgot.dart';
import 'package:kyw_management/app/widgets/forgot_password_screens/submit_code_forgot_button.dart';
import 'package:kyw_management/app/widgets/my_title.dart';

import '../../domain/blocs/blocs_export.dart';
import '../widgets/forgot_password_screens/forgot_to_go_sign_in.dart';

class ForgotValidationCodeScreen extends StatefulWidget {
  const ForgotValidationCodeScreen({super.key});

  @override
  State<ForgotValidationCodeScreen> createState() =>
      _ForgotValidationCodeScreenState();
}

class _ForgotValidationCodeScreenState
    extends State<ForgotValidationCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyTitle(title: 'FORGOT PASSWORD'),
            CodeInputForgot(),
            SubmitCodeForgotButton(),
            ForgotToGoSignIn(),
          ],
        ),
      ),
    );
  }
}
