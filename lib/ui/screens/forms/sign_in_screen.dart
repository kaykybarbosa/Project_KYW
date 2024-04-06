import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/state_management/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:kyw_management/ui/widgets/my_title.dart';
import 'package:kyw_management/ui/widgets/sign_in_form/email_sign_in_input.dart';
import 'package:kyw_management/ui/widgets/sign_in_form/password_sign_in_input.dart';
import 'package:kyw_management/ui/widgets/sign_in_form/submit_sign_in_button.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/forgot_password_button.dart';

import '../../widgets/sign_in_form/message_to_registred.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            Get.offAllNamed(AppRoutes.home);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Title the screen
                  const MyTitle(title: 'LOGIN'),

                  Column(
                    children: [
                      // Input the email
                      const EmailSignInInput(),

                      // Input the password
                      const PasswordSignInInput(),

                      // Forgot password
                      ForgotPasswordButton(onTap: () => Get.toNamed(AppRoutes.emailForgotPassword)),
                    ],
                  ),

                  // Submit form
                  const SubmitSignInButton(),

                  // Message go to create account
                  const MessageToRegistered()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}