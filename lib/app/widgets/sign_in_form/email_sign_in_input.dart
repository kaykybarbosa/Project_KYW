import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

class EmailSignInInput extends StatelessWidget {
  const EmailSignInInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextFormField(
            initialValue: state.email.value,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
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
