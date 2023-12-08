import 'package:flutter/material.dart';

import '../../../domain/blocs/auth_export.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    super.key,
    required FocusNode nameFocusNode,
  }) : _nameFocusNode = nameFocusNode;

  final FocusNode _nameFocusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return TextFormField(
            initialValue: state.name.value,
            focusNode: _nameFocusNode,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Name',
              border: const OutlineInputBorder(),
              errorText: state.name.displayError != null
                  ? "Por favor, informe um nome!"
                  : null,
            ),
            onChanged: (name) =>
                context.read<AuthBloc>().add(NameAuthChanged(name: name)),
          );
        },
      ),
    );
  }
}
