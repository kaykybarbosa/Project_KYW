import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';
import 'package:kyw_management/domain/cubits/change_number_cubit/change_number_cubit.dart';

class ChangeNumberScreen extends StatelessWidget {
  const ChangeNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return MyScaffold(
      arrowBack: () {
        context.pop(context);
      },
      title: 'Mudar número',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Form(
            child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: (screenSize.height / 1.3),
            child: BlocProvider(
              create: (context) => ChangeNumberCubit(),
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
        )),
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
      child: BlocBuilder<ChangeNumberCubit, ChangeNumberState>(
        buildWhen: (previous, current) =>
            previous.newNumber != current.newNumber,
        builder: (context, state) {
          return TextFormField(
              initialValue: state.newNumber.value,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.5)),
                hintText: 'Novo número',
                border: const OutlineInputBorder(),
                errorText: state.newNumber.displayError != null
                    ? "Número inválido!"
                    : null,
              ),
              onChanged: (number) =>
                  context.read<ChangeNumberCubit>().newNumberChanged(number));
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
      child: BlocBuilder<ChangeNumberCubit, ChangeNumberState>(
        buildWhen: (previous, current) =>
            previous.currentNumber != current.currentNumber,
        builder: (context, state) {
          return TextFormField(
              initialValue: state.currentNumber.value,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.5)),
                hintText: 'Novo número',
                border: const OutlineInputBorder(),
                errorText: state.currentNumber.displayError != null
                    ? "Número inválido!"
                    : null,
              ),
              onChanged: (number) => context
                  .read<ChangeNumberCubit>()
                  .currentNumberChanged(number));
        },
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeNumberCubit, ChangeNumberState>(
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
                          .read<ChangeNumberCubit>()
                          .formChangeNumberSubmitted()
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
