import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

class EmailInputForgot extends StatelessWidget {
  const EmailInputForgot({
    super.key,
    required FocusNode emailFocusNode,
  }) : _emailFocusNode = emailFocusNode;

  final FocusNode _emailFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Digite o e-mail cadastrado em sua conta',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 17,
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.email.value,
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  border: const OutlineInputBorder(),
                  errorText: state.email.displayError != null
                      ? "Por favor, informe um e-mail válido!"
                      : null,
                ),
                onChanged: (email) => context
                    .read<ForgotPasswordBloc>()
                    .add(EmailForgotPasswordChanged(email: email)),
              );
            },
          ),
        ),
      ],
    );
  }
}
