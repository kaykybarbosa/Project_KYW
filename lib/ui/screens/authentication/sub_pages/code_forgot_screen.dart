import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/state_management/cubits/forgot_code_cubit/forgot_code_cubit.dart';
import 'package:kyw_management/ui/widgets/forgot_password_screens/code_input_forgot.dart';
import 'package:kyw_management/ui/widgets/forgot_password_screens/submit_code_forgot_button.dart';
import 'package:kyw_management/ui/widgets/go_to_sign_in.dart';

class CodeForgotScreen extends StatefulWidget {
  const CodeForgotScreen({super.key});

  @override
  State<CodeForgotScreen> createState() => _CodeForgotScreenState();
}

class _CodeForgotScreenState extends State<CodeForgotScreen> {
  @override
  Widget build(BuildContext context) {
    /// TODO: Remover registro do cubit e refatorar tela
    return BlocProvider(
      create: (context) => ForgotCodeCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: BlocListener<ForgotCodeCubit, ForgotCodeState>(
            listener: (context, state) {
              if (state.status.isFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Código Inválido!'),
                    ),
                  );
              }
              if (state.status.isSuccess) {
                Get.offAllNamed(AppRoutes.changePassword);
              }
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTitle(title: 'FORGOT PASSWORD'),
                CodeInputForgot(),
                SubmitCodeForgotButton(),
                GoToSignIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
