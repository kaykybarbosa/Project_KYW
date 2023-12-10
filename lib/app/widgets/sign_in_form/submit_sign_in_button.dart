import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

class SubmitSignInButton extends StatelessWidget {
  const SubmitSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? CircularProgressIndicator(color: Theme.of(context).primaryColor)
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      disabledForegroundColor:
                          const Color.fromARGB(90, 238, 238, 238)),
                  onPressed: state.isValid
                      ? () =>
                          context.read<SignInBloc>().add(FormSignInSubmitted())
                      : null,
                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
      },
    );
  }
}
