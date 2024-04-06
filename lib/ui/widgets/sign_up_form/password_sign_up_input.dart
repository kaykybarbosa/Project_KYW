import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/sign_up_bloc/sign_up_bloc.dart';

class PasswordSignUpInput extends StatelessWidget {
  const PasswordSignUpInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          obscureText: true,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Senha',
            border: const OutlineInputBorder(),
            errorText: state.password.displayError != null ? "Senha inválida!" : null,
          ),
          onChanged: (password) => context.read<SignUpBloc>().add(PasswordSignUpChanged(password: password)),
        );
      },
    );
  }
}
