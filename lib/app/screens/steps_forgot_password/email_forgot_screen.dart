import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/widgets/my_title.dart';
import 'package:kyw_management/domain/cubits/forgot_email_cubit/forgot_email_cubit.dart';
import 'package:kyw_management/domain/services/routers/export_routes.dart';

import '../../../domain/blocs/blocs_export.dart';
import '../../widgets/forgot_password_screens/email_input_forgot.dart';
import '../../widgets/forgot_password_screens/forgot_to_go_sign_in.dart';
import '../../widgets/forgot_password_screens/submit_email_forgot_button.dart';

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
                GoRouter.of(context).push(MyRoutes.codeForgotPassword);
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
