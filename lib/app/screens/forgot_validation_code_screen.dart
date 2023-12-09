import 'package:flutter/material.dart';
import 'package:kyw_management/app/widgets/forgot_password_screens/submit_forgot_button.dart';
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
  final _codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _codeFocusNode.addListener(() {
      if (!_codeFocusNode.hasFocus) {
        context.read<ForgotPasswordBloc>().add(CodeForgotPasswordUnfocused());
      }
    });
    context.read<ForgotPasswordBloc>().add(StepForgotPasswordChanged());
  }

  @override
  void dispose() {
    super.dispose();
    _codeFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Title
            const MyTitle(title: 'FORGOT PASSWORD'),

            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              builder: (context, state) {
                return SizedBox(
                  width: 200,
                  child: TextFormField(
                    initialValue: state.code.value,
                    focusNode: _codeFocusNode,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: '* * * - * * *',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      border: const OutlineInputBorder(),
                      errorText: state.code.displayError != null
                          ? "Código Inválido!"
                          : null,
                    ),
                    onChanged: (value) => context
                        .read<ForgotPasswordBloc>()
                        .add(CodeForgotPasswordChanged(code: value)),
                  ),
                );
              },
            ),

            // Button submit code
            const SubmitForgotButton(),

            // Link
            const ForgotToGoSignIn(),
          ],
        ),
      ),
    );
  }
}
