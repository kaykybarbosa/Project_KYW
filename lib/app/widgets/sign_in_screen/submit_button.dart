import 'package:flutter/material.dart';

import '../../../domain/blocs/sign_in_export.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isValid = context.select((SignInBloc bloc) => bloc.state.isValid);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid
            ? () => context.read<SignInBloc>().add(FormSignInSubmitted())
            : null,
        child: const Text(
          'ENTRAR',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
