import 'package:flutter/material.dart';

import '../../../domain/blocs/auth_export.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isValid = context.select((AuthBloc bloc) => bloc.state.isValid);
    final FormType formType =
        context.select((AuthBloc bloc) => bloc.state.formType);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledForegroundColor: const Color.fromARGB(90, 238, 238, 238),
        ),
        onPressed: isValid
            ? () => context
                .read<AuthBloc>()
                .add(FormAuthSubmitted(formType: formType.name))
            : null,
        child: Text(
          formType == FormType.signIn ? 'ENTRAR' : 'CRIAR CONTA',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
