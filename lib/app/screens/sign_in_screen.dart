import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/widgets/form_screen/forgot_password_button.dart';
import 'package:kyw_management/app/widgets/auth_screens/email_input.dart';
import 'package:kyw_management/app/widgets/auth_screens/password_input.dart';
import 'package:kyw_management/app/widgets/auth_screens/submit_button.dart';
import 'package:kyw_management/domain/blocs/auth_export.dart';

import '../widgets/my_title.dart';
import '../widgets/auth_screens/message_to_registred.dart';

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
        context.read<AuthBloc>().add(EmailAuthUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<AuthBloc>().add(PasswordAuthUnfocused());
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status.isInProgress) {}
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
                      EmailInput(emailFocusNode: _emailFocusNode),

                      // Input the password
                      PasswordInput(passwordFocusNode: _passwordFocusNode),

                      // Forgot password
                      ForgotPasswordButton(
                        onTap: () =>
                            GoRouter.of(context).push(MyRoutes.forgotPassword),
                      )
                    ],
                  ),

                  // Submit form
                  const SubmitButton(),

                  // Circular indicator
                  Visibility(
                    visible: context.select(
                        (AuthBloc bloc) => bloc.state.status.isInProgress),
                    child: const CircularProgressIndicator(),
                  ),

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
