import 'package:flutter/material.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/cubits/change_password_cubit/change_password_cubit.dart';

class ChangeConfirmedPasswordInput extends StatelessWidget {
  const ChangeConfirmedPasswordInput({
    super.key,
    required TextEditingController confirmedPasswordController,
  }) : _confirmedPasswordController = confirmedPasswordController;

  final TextEditingController _confirmedPasswordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextFormField(
          controller: _confirmedPasswordController,
          obscureText: true,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Confirme senha',
            border: const OutlineInputBorder(),
            errorText: state.confirmedPassword.displayError != null
                ? "As senhas não são iguais!"
                : null,
          ),
          onChanged: (password) => context
              .read<ChangePasswordCubit>()
              .confirmedPasswordChanged(password),
        );
      },
    );
  }
}
