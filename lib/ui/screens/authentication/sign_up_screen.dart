import 'package:flutter/material.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/continue_with.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/email_sign_up_input.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/message_to_sign_in.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/name_sign_up_input.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/password_sign_up_input.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/sign_google_facebook.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/submit_sign_up_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 800,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Title the screen
                MyTitle(title: 'REGISTER'),

                Column(
                  children: [
                    // Name the form
                    NameSignUpInput(),

                    // Email the form
                    EmailSignUpInput(),

                    // Password the form
                    PasswordSignUpInput(),

                    // Continue with
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 12),
                      child: ContinueWith(),
                    ),

                    // Google or Facebook
                    SignGoogleFacebook(),
                  ],
                ),

                SizedBox(height: 30),

                // Button for submited form
                SubmitSignUpButton(),

                SizedBox(height: 30),

                // Message to go Sign In
                MessageToSignIn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
