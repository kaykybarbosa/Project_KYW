import 'package:flutter/material.dart';

import '../../../domain/blocs/blocs_export.dart';

class SubmitSignUpButton extends StatelessWidget {
  const SubmitSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                disabledForegroundColor:
                    const Color.fromARGB(90, 238, 238, 238)),
            onPressed: state.isValid
                ? () => context.read<SignUpBloc>().add(FormSignUpSubmitted())
                : null,
            child: state.status.isInProgress
                ? Transform.scale(
                    scale: 0.44,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    'REGISTRA-SE',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        );
      },
    );
  }
}
