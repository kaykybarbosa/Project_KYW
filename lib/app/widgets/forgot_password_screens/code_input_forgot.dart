import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/cubits/forgot_code_cubit/forgot_code_cubit.dart';

class CodeInputForgot extends StatelessWidget {
  const CodeInputForgot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotCodeCubit, ForgotCodeState>(
      builder: (context, state) {
        return SizedBox(
          width: 200,
          child: TextFormField(
              initialValue: state.code.value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: '* * * - * * *',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                border: const OutlineInputBorder(),
                errorText:
                    state.code.displayError != null ? "Código Inválido!" : null,
              ),
              onChanged: (code) =>
                  context.read<ForgotCodeCubit>().codeChanged(code)),
        );
      },
    );
  }
}
