import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

class EmailSignUpInput extends StatelessWidget {
  const EmailSignUpInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
                .read<SignUpBloc>()
                .add(EmailSignUpChanged(email: email)),
          );
        },
      ),
    );
  }
}
