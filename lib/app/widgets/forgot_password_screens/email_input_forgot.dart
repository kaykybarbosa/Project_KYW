import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

class EmailInputForgot extends StatelessWidget {
  const EmailInputForgot({
    super.key,
    required FocusNode emailFocusNode,
    required TextEditingController emailController,
  })  : _emailFocusNode = emailFocusNode,
        _emailController = emailController;

  final FocusNode _emailFocusNode;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Digite o e-mail cadastrado em sua conta',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              return TextFormField(
                controller: _emailController,
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
