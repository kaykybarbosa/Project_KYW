import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/enums/snack_bar_type.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/button_network.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/state_management/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:kyw_management/ui/widgets/back_button_ios.dart';
import 'package:kyw_management/ui/widgets/go_to_sign_in.dart';
import 'package:kyw_management/ui/widgets/my_password_text_field.dart';
import 'package:kyw_management/ui/widgets/my_text_field.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/snack_bar/snack_bar_custom.dart';
import 'package:kyw_management/utils/texts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isFailure) {
            snackBarCustom(
              message: state.errorMessage,
              type: SnackBarType.danger,
            );
          } else if (state.status.isSuccess) {
            snackBarCustom(
              title: 'Sucesso!',
              message: 'Seu cadastro foi realizado.',
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              /// Body
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Gap(10),

                    /// -- Formulário
                    const Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            /// -- Título
                            MyTitle(title: 'Crie sua conta'),

                            /// -- Nome
                            _NameInput(),
                            Gap(20),

                            /// -- E-mail
                            _EmailInput(),
                            Gap(20),

                            /// -- Senha
                            _PasswordInput(),
                            Gap(15),

                            /// -- Continue com
                            _ContinueWith(),

                            /// -- Google ou Facebook
                            _SignUpGoogleFacebook(),

                            Gap(50),

                            /// Botão de registro
                            _SubmitButton(),
                            Gap(15),
                          ],
                        ),
                      ),
                    ),

                    /// -- Acessar conta
                    GoToSignIn(onTap: () => Get.back()),
                  ],
                ),
              ),

              /// Botão de voltar
              const BackButtonIOS(),
            ],
          ),
        ),
      );
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.name.value != current.name.value,
        builder: (context, state) => MyTextFormField(
          initialValue: state.name.value,
          keyboardType: TextInputType.name,
          hintText: 'Nome',
          errorText: state.name.displayError,
          onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
        ),
      );
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.email.value != current.email.value,
        builder: (context, state) => MyTextFormField(
          hintText: 'E-mail',
          initialValue: state.email.value,
          keyboardType: TextInputType.emailAddress,
          errorText: state.email.displayError != null ? "Por favor, informe um e-mail válido!" : null,
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
        ),
      );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.password.value != current.password.value || previous.obscureText != current.obscureText,
        builder: (context, state) => MyPasswordTextField(
          hintText: 'Senha',
          initialValue: state.password.value,
          errorText: state.password.displayError,
          obscureText: state.obscureText,
          suffixOnTap: () => context.read<SignUpCubit>().obscureChanged(),
          onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
        ),
      );
}

class _ContinueWith extends StatelessWidget {
  const _ContinueWith();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.only(top: 20, bottom: 12),
        child: Row(
          children: <Widget>[
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: TConstants.fontSizeMd),
              child: Text(
                TTexts.continueWith,
                style: TextStyle(color: TColors.base200),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
      );
}

class _SignUpGoogleFacebook extends StatelessWidget {
  const _SignUpGoogleFacebook();

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /// Google
          ButtonNetwork(
            text: 'Google',
            image: Image.asset(
              'assets/Google.webp',
              width: 28,
            ),
            width: 140,
          ),

          /// Facebook
          ButtonNetwork(
            text: 'Facebook',
            image: Image.asset(
              'assets/Facebook-logo.webp',
              width: 28.5,
            ),
          ),
        ],
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) => SubmitButton(
          label: 'Criar conta',
          isInProgress: state.status.isInProgress,
          onPressed: state.isValid
              ? () => {
                    context.read<SignUpCubit>().formSubmitted(),
                    FocusScope.of(context).unfocus(),
                  }
              : null,
        ),
      );
}
