import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/domain/cubits/two_step_verification_cubit/two_step_verification_cubit.dart';

import '../../../domain/blocs/blocs_export.dart';

class TwoStepVerificationScreen extends StatefulWidget {
  const TwoStepVerificationScreen({super.key});

  @override
  State<TwoStepVerificationScreen> createState() =>
      _TwoStepVerificationScreenState();
}

class _TwoStepVerificationScreenState extends State<TwoStepVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Configuração de duas etapas')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: (screenSize.height / 1.3),
            child: BlocProvider(
              create: (context) => TwoStepVerificationCubit(),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text for enter email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TextTheInput(),
                      _EmailInput(),

                      // Message the info
                      _MesssageInfo(),
                    ],
                  ),

                  // const SizedBox(height: 300),

                  // Button enable verification
                  _SubmitButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextTheInput extends StatelessWidget {
  const _TextTheInput();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        'Insira seu e-mail',
        style: TextStyle(fontSize: 19.0),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<TwoStepVerificationCubit, TwoStepVerificationState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextFormField(
              initialValue: state.email.value,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.5)),
                hintText: 'E-mail ou Número',
                border: const OutlineInputBorder(),
                errorText: state.email.displayError != null
                    ? "Por favor, informe um e-mail válido!"
                    : null,
              ),
              onChanged: (email) =>
                  context.read<TwoStepVerificationCubit>().emailChanged(email));
        },
      ),
    );
  }
}

class _MesssageInfo extends StatelessWidget {
  const _MesssageInfo();

  @override
  Widget build(BuildContext context) {
    const String info =
        'Para garantir a segurança da sua conta, estamos aplicando uma camada adicional de proteção. Este processo adiciona uma barreira vital contra acessos não autorizados e mantém seus dados pessoais seguros.';

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Text(
        info,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TwoStepVerificationCubit, TwoStepVerificationState>(
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
                          .read<TwoStepVerificationCubit>()
                          .formTwoStepSubmitted()
                      : null,
                  child: const Text(
                    'Habilitar Verificação',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
      },
    );
  }
}
