import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

class SubmitSignUpButton extends StatelessWidget {
  const SubmitSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
                          context.read<SignUpBloc>().add(FormSignUpSubmitted())
                      : null,
                  child: const Text(
                    'REGISTRA-SE',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
      },
    );
  }
}
