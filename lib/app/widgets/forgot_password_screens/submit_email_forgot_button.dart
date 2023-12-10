import 'package:flutter/material.dart';
import 'package:kyw_management/domain/cubits/forgot_email_cubit/forgot_email_cubit.dart';

import '../../../domain/blocs/blocs_export.dart';

class SubmitEmailForgotButton extends StatelessWidget {
  const SubmitEmailForgotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotEmailCubit, ForgotEmailState>(
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
                      ? () => context.read<ForgotEmailCubit>().formSubmitted()
                      : null,
                  child: const Text(
                    'RECEBER CÓDIGO',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
      },
    );
  }
}
