import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/cubits/forgot_email_cubit/forgot_email_cubit.dart';

class EmailInputForgot extends StatelessWidget {
  const EmailInputForgot({super.key});

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
          child: BlocBuilder<ForgotEmailCubit, ForgotEmailState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return TextFormField(
                  initialValue: state.email.value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    border: const OutlineInputBorder(),
                    errorText: state.email.displayError != null ? "Por favor, informe um e-mail válido!" : null,
                  ),
                  onChanged: (email) => context.read<ForgotEmailCubit>().emailChanged(email));
            },
          ),
        ),
      ],
    );
  }
}
