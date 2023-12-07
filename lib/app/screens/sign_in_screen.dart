import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/app/widgets/form_screen/forgot_password_button.dart';
import 'package:kyw_management/app/widgets/sign_in_screen/email_input.dart';
import 'package:kyw_management/app/widgets/sign_in_screen/password_input.dart';
import 'package:kyw_management/app/widgets/sign_in_screen/submit_button.dart';
import 'package:kyw_management/domain/blocs/sign_in_export.dart';

import '../widgets/my_title.dart';
import '../widgets/sign_in_screen/message_to_registred.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignInBloc>().add(EmailSignInUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SignInBloc>().add(PasswordSignInUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.status.isSuccess) {}

          if (state.status.isInProgress) {}
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Title the screen
              const MyTitle(title: 'LOGIN'),

              Column(
                children: [
                  // Input the email
                  EmailInput(emailFocusNode: _emailFocusNode),

                  // Input the password
                  PasswordInput(passwordFocusNode: _passwordFocusNode),

                  // Forgot password
                  ForgotPasswordButton(onTap: () {}),
                ],
              ),

              // Submit form
              const SubmitButton(),

              // Circular indicator
              Visibility(
                visible: context.select(
                    (SignInBloc bloc) => bloc.state.status.isInProgress),
                child: const CircularProgressIndicator(),
              ),

              // Message go to create account
              const MessageToRegistered()
            ],
          ),
        ),
      ),
    );
  }
}
