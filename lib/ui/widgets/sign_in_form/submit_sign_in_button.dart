import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/ui/state_management/blocs/sign_in_bloc/sign_in_bloc.dart';

class SubmitSignInButton extends StatelessWidget {
  const SubmitSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(disabledForegroundColor: const Color.fromARGB(90, 238, 238, 238)),
            onPressed: state.isValid ? () => context.read<SignInBloc>().add(FormSignInSubmitted()) : null,
            child: state.status.isInProgress
                ? Transform.scale(
                    scale: 0.44,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    'ENTRAR',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        );
      },
    );
  }
}
