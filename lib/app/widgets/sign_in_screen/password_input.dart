import 'package:flutter/material.dart';

import '../../../domain/blocs/sign_in_export.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required FocusNode passwordFocusNode,
  }) : _passwordFocusNode = passwordFocusNode;

  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: _passwordFocusNode,
          decoration: InputDecoration(
            hintText: 'Senha',
            border: const OutlineInputBorder(),
            errorText: state.password.displayError != null
                ? "Sua senha deve conter pelo menos 6 caracteres!"
                : null,
          ),
          onChanged: (password) => context
              .read<SignInBloc>()
              .add(PasswordSignInChanged(password: password)),
        );
      },
    );
  }
}
