import 'package:flutter/material.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/cubits/change_password_cubit/change_password_cubit.dart';

class SubmitChangePasswordButton extends StatelessWidget {
  const SubmitChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
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
                      ? () => context
                          .read<ChangePasswordCubit>()
                          .formChangePasswordSubmitted()
                      : null,
                  child: const Text(
                    'CONCLUIR',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
      },
    );
  }
}
