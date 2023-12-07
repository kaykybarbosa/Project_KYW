import 'package:flutter/material.dart';

import '../../../domain/blocs/sign_in_export.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required FocusNode emailFocusNode,
  }) : _emailFocusNode = emailFocusNode;

  final FocusNode _emailFocusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return TextFormField(
            initialValue: state.email.value,
            focusNode: _emailFocusNode,
            decoration: InputDecoration(
              hintText: 'E-mail ou Número',
              border: const OutlineInputBorder(),
              errorText: state.email.displayError != null
                  ? "Por favor, informe um e-mail válido!"
                  : null,
            ),
            onChanged: (email) => context
                .read<SignInBloc>()
                .add(EmailSignInChanged(email: email)),
          );
        },
      ),
    );
  }
}
