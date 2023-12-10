import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/domain/cubits/forgot_code_cubit/forgot_code_cubit.dart';

class SubmitCodeForgotButton extends StatelessWidget {
  const SubmitCodeForgotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotCodeCubit, ForgotCodeState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? CircularProgressIndicator(color: Theme.of(context).primaryColor)
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledForegroundColor:
                        const Color.fromARGB(90, 238, 238, 238),
                  ),
                  onPressed: state.isValid
                      ? () => context.read<ForgotCodeCubit>().formSubmitted()
                      : null,
                  child: const Text(
                    'AVANÇAR',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
      },
    );
  }
}
