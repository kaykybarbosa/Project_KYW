import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

class SubmitForgotButton extends StatelessWidget {
  const SubmitForgotButton({super.key});

  @override
  Widget build(BuildContext context) {
    bool isValid =
        context.select((ForgotPasswordBloc bloc) => bloc.state.isValid);
    var step = context.select((ForgotPasswordBloc bloc) => bloc.state.step);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledForegroundColor: const Color.fromARGB(90, 238, 238, 238),
        ),
        onPressed: isValid
            ? () => context
                .read<ForgotPasswordBloc>()
                .add(FormForgotPasswordSubmitted())
            : null,
        child: Text(
          step == StepsForgotPassword.gettingEmail
              ? 'RECEBER CÓDIGO'
              : 'AVANÇAR',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
