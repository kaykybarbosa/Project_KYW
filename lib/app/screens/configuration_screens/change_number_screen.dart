import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/domain/cubits/change_phone_cubit/change_phone_cubit.dart';

class ChangeNumberScreen extends StatelessWidget {
  const ChangeNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mudar número')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: BlocProvider(
          create: (context) => ChangePhoneCubit(),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text new number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TextTheInput(label: 'Insira seu número novo'),

                  // Input new number
                  _NewNumberInput(),

                  // Text old number
                  _TextTheInput(label: 'Insira seu número atual '),

                  // Imput old number
                  _CurrentNumberInput(),
                ],
              ),

              // Button change number
              _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextTheInput extends StatelessWidget {
  const _TextTheInput({required String label}) : _label = label;

  final String _label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Text(
        _label,
        style: const TextStyle(fontSize: 19.0),
      ),
    );
  }
}

class _NewNumberInput extends StatelessWidget {
  const _NewNumberInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<ChangePhoneCubit, ChangePhoneState>(
        buildWhen: (previous, current) => previous.newPhone != current.newPhone,
        builder: (context, state) {
          return TextFormField(
              initialValue: state.newPhone.value,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.5)),
                hintText: 'Número novo',
                border: const OutlineInputBorder(),
                errorText: state.newPhone.displayError != null
                    ? "Número inválido!"
                    : null,
              ),
              onChanged: (number) =>
                  context.read<ChangePhoneCubit>().newPhoneChanged(number));
        },
      ),
    );
  }
}

class _CurrentNumberInput extends StatelessWidget {
  const _CurrentNumberInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<ChangePhoneCubit, ChangePhoneState>(
        buildWhen: (previous, current) =>
            previous.currentPhone != current.currentPhone,
        builder: (context, state) {
          return TextFormField(
              initialValue: state.currentPhone.value,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.5)),
                hintText: 'Número atual',
                border: const OutlineInputBorder(),
                errorText: state.currentPhone.displayError != null
                    ? "Número inválido!"
                    : null,
              ),
              onChanged: (number) =>
                  context.read<ChangePhoneCubit>().currentPhoneChanged(number));
        },
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePhoneCubit, ChangePhoneState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? CircularProgressIndicator(color: Theme.of(context).primaryColor)
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                        state.isValid ? Colors.white : Colors.white70),
                    backgroundColor: MaterialStatePropertyAll(state.isValid
                        ? const Color.fromARGB(255, 6, 172, 147)
                        : const Color.fromARGB(240, 6, 172, 147)),
                  ),
                  onPressed: state.isValid
                      ? () => context
                          .read<ChangePhoneCubit>()
                          .formChangePhoneSubmitted()
                      : null,
                  child: const Text(
                    'Alterar número',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
      },
    );
  }
}
