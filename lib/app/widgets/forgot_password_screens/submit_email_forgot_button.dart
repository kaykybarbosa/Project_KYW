import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/domain/cubits/forgot_email_cubit/forgot_email_cubit.dart';

class SubmitEmailForgotButton extends StatelessWidget {
  const SubmitEmailForgotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotEmailCubit, ForgotEmailState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledForegroundColor: const Color.fromARGB(90, 238, 238, 238),
            ),
            onPressed: state.isValid ? () => context.read<ForgotEmailCubit>().formSubmitted() : null,
            child: state.status.isInProgress
                ? Transform.scale(
                    scale: 0.44,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    'RECEBER CÓDIGO',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        );
      },
    );
  }
}
