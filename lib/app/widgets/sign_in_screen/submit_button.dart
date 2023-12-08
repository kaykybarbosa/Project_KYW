import 'package:flutter/material.dart';

import '../../../domain/blocs/sign_in_export.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isValid =
        context.select((SignInBloc bloc) => bloc.state.isValid);
    final FormType formType =
        context.select((SignInBloc bloc) => bloc.state.formType);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid
            ? () => context
                .read<SignInBloc>()
                .add(FormSignInSubmitted(formType: formType.name))
            : null,
        child: Text(
          formType == FormType.signIn ? 'ENTRAR' : 'CRIAR CONTA',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
