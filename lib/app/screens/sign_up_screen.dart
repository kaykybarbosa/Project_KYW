import 'package:flutter/material.dart';
import 'package:kyw_management/app/widgets/sign_in_screen/email_input.dart';
import 'package:kyw_management/app/widgets/sign_in_screen/message_to_sign_in.dart';
import 'package:kyw_management/app/widgets/sign_in_screen/password_input.dart';
import 'package:kyw_management/app/widgets/sign_in_screen/submit_button.dart';

import '../../domain/blocs/sign_in_export.dart';
import '../widgets/form_screen/continue_with.dart';
import '../widgets/form_screen/sign_google_facebook.dart';
import '../widgets/my_title.dart';
import '../widgets/sign_in_screen/name_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<SignInBloc>().add(NameSignUpUnfocused());
        // FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignInBloc>().add(EmailSignInUnfocused());
        // FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SignInBloc>().add(PasswordSignInUnfocused());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Title the screen
                const MyTitle(title: 'REGISTER'),

                Column(
                  children: [
                    // Name the form
                    NameInput(nameFocusNode: _nameFocusNode),

                    // Email the form
                    EmailInput(emailFocusNode: _emailFocusNode),

                    // Password the form
                    PasswordInput(passwordFocusNode: _passwordFocusNode),

                    // Continue with
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 12),
                      child: ContinueWith(),
                    ),

                    // Google or Facebook
                    const SignGoogleFacebook(),
                  ],
                ),

                const SizedBox(height: 30),

                // Button for submited form
                const SubmitButton(),

                // Message to go Sign In
                const MessageToSignIn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
