import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/ui/state_management/cubits/delete_account_cubit/delete_account_cubit.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Deletar conta')),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: SizedBox(
            height: (screenSize.height / 1.20),
            child: BlocProvider(
              create: (context) => DeleteAccountCubit(),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text the enter phone or email
                  Column(
                    children: [
                      _CardInformationsDeleted(),

                      SizedBox(height: 30.0),

                      _TextTheInput(),

                      // Input for enter phone or email
                      _EmailInput(),
                    ],
                  ),

                  // Button delete account
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
    const String textEnterPhoneOrEmail = 'Para excluir sua conta, digite seu número de telefone ou e-mail abaixo:';

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        textEnterPhoneOrEmail,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _CardInformationsDeleted extends StatelessWidget {
  const _CardInformationsDeleted();

  @override
  Widget build(BuildContext context) {
    const String titleInfo = 'O que acontecerá quando você excluir a conta:';
    const String firstInfo = '- Todos os seus dados vinculados a esta conta serão apagados permanentemente.';
    const String secoundInfo = '- Você sairá de todos os projetos.';
    const String thirdInfo = '- Todo o seu histórico será deletado.';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(50, 58, 71, 1),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // First part
          Row(
            children: [
              Icon(
                FontAwesomeIcons.triangleExclamation,
                color: CupertinoColors.systemYellow,
                size: 45.0,
              ),

              SizedBox(width: 20.0),

              // Message [Will happen case continues]
              Expanded(
                child: Text(
                  titleInfo,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'source',
                    color: CupertinoColors.systemYellow,
                  ),
                ),
              )
            ],
          ),

          // Information abount what will happen
          _Informations(text: firstInfo),
          _Informations(text: secoundInfo),
          _Informations(text: thirdInfo),
        ],
      ),
    );
  }
}

class _Informations extends StatelessWidget {
  const _Informations({required String text}) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        _text,
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
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
      child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
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
              onChanged: (email) => context.read<DeleteAccountCubit>().emailChanged(email));
        },
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(state.isValid ? Colors.white : Colors.white70),
              backgroundColor:
                  WidgetStatePropertyAll(state.isValid ? Colors.red : const Color.fromARGB(250, 244, 67, 54)),
            ),
            onPressed: state.isValid ? () => context.read<DeleteAccountCubit>().formDeleteAccountSubimitted() : null,
            child: state.status.isInProgress
                ? Transform.scale(
                    scale: 0.44,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    'Deletar Conta',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        );
      },
    );
  }
}
