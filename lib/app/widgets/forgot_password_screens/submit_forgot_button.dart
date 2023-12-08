import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/blocs/blocs_export.dart';
import '../../enums/my_routes.dart';

class SubmitForgotButton extends StatelessWidget {
  const SubmitForgotButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var nextStep = context.select((ForgotPasswordBloc bloc) => bloc.state.step);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledForegroundColor: const Color.fromARGB(90, 238, 238, 238),
        ),
        onPressed: () {
          context.read<ForgotPasswordBloc>().add(FormForgotPasswordSubmitted());

          // if (nextStep == StepsForgotPassword.validationCode) {
          //   GoRouter.of(context).push(MyRoutes.home);
          // }
        },
        child: const Text(
          'ENVIAR CÓDIGO',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
