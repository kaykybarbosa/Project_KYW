import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/ui/state_management/cubits/change_password_cubit/change_password_cubit.dart';

class ChangePasswordInput extends StatelessWidget {
  const ChangePasswordInput({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          controller: _passwordController,
          obscureText: true,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Senha',
            border: const OutlineInputBorder(),
            errorText: state.password.displayError != null ? "Senha inválida!" : null,
          ),
          onChanged: (password) => context.read<ChangePasswordCubit>().passwordChanged(password),
        );
      },
    );
  }
}
