import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/state_management/cubits/forgot_email_cubit/forgot_email_cubit.dart';
import 'package:kyw_management/ui/widgets/forgot_password_screens/email_input_forgot.dart';
import 'package:kyw_management/ui/widgets/forgot_password_screens/forgot_to_go_sign_in.dart';
import 'package:kyw_management/ui/widgets/forgot_password_screens/submit_email_forgot_button.dart';

class EmailForgotScreen extends StatefulWidget {
  const EmailForgotScreen({super.key});

  @override
  State<EmailForgotScreen> createState() => _EmailForgotScreenState();
}

class _EmailForgotScreenState extends State<EmailForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotEmailCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: BlocListener<ForgotEmailCubit, ForgotEmailState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                Get.toNamed(AppRoutes.codeForgotPassword);
              }
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Title
                MyTitle(title: 'FORGOT PASSWORD'),

                // Message and input the email
                EmailInputForgot(),

                // Buttom send e-mail
                SubmitEmailForgotButton(),

                // Link
                ForgotToGoSignIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
