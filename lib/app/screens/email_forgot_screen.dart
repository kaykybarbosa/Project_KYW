import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/widgets/my_title.dart';

import '../../domain/blocs/blocs_export.dart';
import '../widgets/forgot_password_screens/email_input_forgot.dart';
import '../widgets/forgot_password_screens/forgot_to_go_sign_in.dart';
import '../widgets/forgot_password_screens/submit_email_forgot_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailFocusNode = FocusNode();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<ForgotPasswordBloc>().add(EmailForgotPasswordUnfocused());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var status = context.select((ForgotPasswordBloc bloc) => bloc.state.status);

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.step == StepsForgotPassword.goToValidationCode) {
          GoRouter.of(context).push(MyRoutes.forgotPasswordValidation);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Title
              const MyTitle(title: 'FORGOT PASSWORD'),

              // Message and input the email
              const EmailInputForgot(),

              // Buttom send e-mail
              const SubmitEmailForgotButton(),

              // IsProgress
              Visibility(
                visible: status == FormzSubmissionStatus.inProgress,
                child: const CircularProgressIndicator(),
              ),

              // Link
              const ForgotToGoSignIn(),
            ],
          ),
        ),
      ),
    );
  }
}
