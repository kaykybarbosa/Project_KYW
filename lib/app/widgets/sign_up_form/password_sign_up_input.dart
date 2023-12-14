import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

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
            errorText:
                state.password.displayError != null ? "Senha inválida!" : null,
          ),
          onChanged: (password) => context
              .read<SignUpBloc>()
              .add(PasswordSignUpChanged(password: password)),
        );
      },
    );
  }
}