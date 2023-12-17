import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/domain/cubits/change_email_cubit/change_email_cubit.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mudar E-mail')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: BlocProvider(
          create: (context) => ChangeEmailCubit(),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TitleTheInput(label: 'Insira seu e-mail novo'),
                  _NewEmailInput(),
                  _TitleTheInput(label: 'Insira seu e-mail atual'),
                  _CurrentEMailInput(),
                ],
              ),
              _SubmitChangeEmailButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitChangeEmailButton extends StatelessWidget {
  const _SubmitChangeEmailButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeEmailCubit, ChangeEmailState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                  state.isValid ? Colors.white : Colors.white70),
              backgroundColor: MaterialStatePropertyAll(state.isValid
                  ? const Color.fromARGB(255, 6, 172, 147)
                  : const Color.fromARGB(240, 6, 172, 147)),
            ),
            onPressed: state.isValid
                ? () =>
                    context.read<ChangeEmailCubit>().formChangeEmailSubmitted()
                : null,
            child: state.status.isInProgress
                ? Transform.scale(
                    scale: 0.44,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    'Alterar e-mail',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        );
      },
    );
  }
}

class _CurrentEMailInput extends StatelessWidget {
  const _CurrentEMailInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<ChangeEmailCubit, ChangeEmailState>(
        buildWhen: (previous, current) =>
            previous.currentEmail != current.currentEmail,
        builder: (context, state) {
          return TextFormField(
            initialValue: state.currentEmail.value,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.5)),
              hintText: 'E-mail atual',
              border: const OutlineInputBorder(),
              errorText: state.currentEmail.displayError != null
                  ? "E-mail inválido!"
                  : null,
            ),
            onChanged: (number) =>
                context.read<ChangeEmailCubit>().currentEmailChanged(number),
          );
        },
      ),
    );
  }
}

class _NewEmailInput extends StatelessWidget {
  const _NewEmailInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<ChangeEmailCubit, ChangeEmailState>(
        buildWhen: (previous, current) => previous.newEmail != current.newEmail,
        builder: (context, state) {
          return TextFormField(
            initialValue: state.newEmail.value,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.5)),
              hintText: 'E-mail novo',
              border: const OutlineInputBorder(),
              errorText: state.newEmail.displayError != null
                  ? "E-mail inválido!"
                  : null,
            ),
            onChanged: (number) =>
                context.read<ChangeEmailCubit>().newEmailChanged(number),
          );
        },
      ),
    );
  }
}

class _TitleTheInput extends StatelessWidget {
  const _TitleTheInput({required String label}) : _label = label;

  final String _label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        _label,
        style: const TextStyle(fontSize: 19.0),
      ),
    );
  }
}
