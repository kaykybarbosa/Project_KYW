import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/state_management/cubits/delete_account_cubit/delete_account_cubit.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DeleteAccountCubit(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Deletar conta')),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: <Widget>[
                          /// Informações
                          _InformationCard(),

                          Gap(30.0),

                          /// Label
                          _Title(),

                          /// E-mail ou telefone
                          _EmailInput(),
                        ],
                      ),
                    ),
                  ),
                ),

                // Button delete account
                _SubmitButton(),
              ],
            ),
          ),
        ),
      );
}

class _Title extends StatelessWidget {
  const _Title();
  final String textEnterPhoneOrEmail = 'Para excluir sua conta, digite seu número de telefone ou e-mail abaixo:';

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          textEnterPhoneOrEmail,
          style: const TextStyle(
            fontSize: TConstants.fontSizeMd,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}

class _InformationCard extends StatelessWidget {
  const _InformationCard();

  @override
  Widget build(BuildContext context) {
    const String titleInfo = 'O que acontecerá quando você excluir a conta:';
    const String firstInfo = '- Todos os seus dados vinculados a esta conta serão apagados permanentemente.';
    const String secoundInfo = '- Você sairá de todos os projetos.';
    const String thirdInfo = '- Todo o seu histórico será deletado.';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: TColors.secondary,
        borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // First part
          Row(
            children: <Widget>[
              Icon(
                TIcons.triangleExclamation,
                color: TColors.alert,
                size: TConstants.iconLg + 8,
              ),

              Gap(20.0),

              /// Título
              Expanded(
                child: Text(
                  titleInfo,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: TConstants.fontSizeLg,
                    fontWeight: FontWeight.w500,
                    color: TColors.alert,
                  ),
                ),
              )
            ],
          ),
          Gap(3),

          /// Informações
          _Informations(firstInfo),
          _Informations(secoundInfo),
          _Informations(thirdInfo),
        ],
      ),
    );
  }
}

class _Informations extends StatelessWidget {
  const _Informations(String text) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          _text,
          style: const TextStyle(
            color: TColors.base100,
            fontSize: TConstants.fontSizeMd,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) => TextFormField(
              initialValue: state.email.value,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.5)),
                hintText: 'E-mail ou Número',
                border: const OutlineInputBorder(),
                errorText: state.email.displayError != null ? "Por favor, informe um e-mail válido!" : null,
              ),
              onChanged: (email) => context.read<DeleteAccountCubit>().emailChanged(email)),
        ),
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SubmitButton(
            label: 'Deletar',
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: TColors.warn,
            ),
            onPressed: state.isValid ? () => context.read<DeleteAccountCubit>().formDeleteAccountSubimitted() : null,
          ),
        ),
      );
}
