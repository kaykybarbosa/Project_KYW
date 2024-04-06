import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/blocs/sign_up_bloc/sign_up_bloc.dart';

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
              errorText: state.email.displayError != null ? "Por favor, informe um e-mail válido!" : null,
            ),
            onChanged: (email) => context.read<SignUpBloc>().add(EmailSignUpChanged(email: email)),
          );
        },
      ),
    );
  }
}
