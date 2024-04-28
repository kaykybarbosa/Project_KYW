import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/state_management/cubits/two_step_verification_cubit/two_step_verification_cubit.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';

class TwoStepVerificationScreen extends StatefulWidget {
  const TwoStepVerificationScreen({super.key});

  @override
  State<TwoStepVerificationScreen> createState() => _TwoStepVerificationScreenState();
}

class _TwoStepVerificationScreenState extends State<TwoStepVerificationScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => TwoStepVerificationCubit(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Configuração de duas etapas')),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TConstants.defaultMargin, vertical: 15),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// -- Título
                        _TextTheInput(),

                        /// -- E-mail
                        _EmailInput(),

                        /// Mensagem
                        _MesssageInfo(),
                      ],
                    ),
                  ),
                ),

                /// Botão de habilitar
                _SubmitButton(),
              ],
            ),
          ),
        ),
      );
}

class _TextTheInput extends StatelessWidget {
  const _TextTheInput();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Insira seu e-mail',
          style: TextStyle(fontSize: 19.0),
        ),
      );
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
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.5)),
                hintText: 'E-mail ou Número',
                border: const OutlineInputBorder(),
                errorText: state.email.displayError != null ? "Por favor, informe um e-mail válido!" : null,
              ),
              onChanged: (email) => context.read<TwoStepVerificationCubit>().emailChanged(email));
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
      padding: EdgeInsets.symmetric(vertical: 25.0),
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
  Widget build(BuildContext context) => BlocBuilder<TwoStepVerificationCubit, TwoStepVerificationState>(
        builder: (context, state) => SubmitButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: TColors.success,
            // disabledForegroundColor: TColors.base100.withOpacity(.5),
            // disabledBackgroundColor: TColors.success.withOpacity(.9),
          ),
          onPressed: state.isValid ? () => context.read<TwoStepVerificationCubit>().formTwoStepSubmitted() : null,
          label: 'Habilitar',
        ),
      );
}
