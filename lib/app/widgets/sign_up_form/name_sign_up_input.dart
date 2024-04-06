import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/blocs/sign_up_bloc/sign_up_bloc.dart';

class NameSignUpInput extends StatelessWidget {
  const NameSignUpInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.name != current.name,
        builder: (context, state) {
          return TextFormField(
            initialValue: state.name.value,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Nome',
              border: const OutlineInputBorder(),
              errorText: state.name.displayError != null ? "Por favor, informe um nome válido!" : null,
            ),
            onChanged: (name) => context.read<SignUpBloc>().add(NameSignUpChanged(name: name)),
          );
        },
      ),
    );
  }
}
