import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/enums/snack_bar_type.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/button_network.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/state_management/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/snack_bar/snack_bar_custom.dart';
import 'package:kyw_management/utils/texts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            snackBarCustom(
              message: state.errorMessage,
              type: SnackBarType.danger,
            );
          }
          if (state.status.isSuccess) {
            snackBarCustom(
              title: 'Sucesso!',
              message: 'Seu cadastro foi realizado.',
            );
          }
        },
        child: const Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Gap(10),

                /// Formulário
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        /// -- Título
                        MyTitle(title: 'REGISTER'),

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

                /// Acessar conta
                _SignIn()
              ],
            ),
          ),
        ),
      );
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.name.value != current.name.value,
        builder: (context, state) => TextFormField(
          initialValue: state.name.value,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'Nome',
            border: const OutlineInputBorder(),
            errorText: state.name.displayError,
          ),
          onChanged: (name) => context.read<SignUpBloc>().add(NameSignUpChanged(name: name)),
        ),
      );
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.email.value != current.email.value,
        builder: (context, state) => TextFormField(
          initialValue: state.email.value,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'E-mail',
            border: const OutlineInputBorder(),
            errorText: state.email.displayError != null ? "Por favor, informe um e-mail válido!" : null,
          ),
          onChanged: (email) => context.read<SignUpBloc>().add(EmailSignUpChanged(email: email)),
        ),
      );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.password.value != current.password.value,
        builder: (context, state) => TextFormField(
          initialValue: state.password.value,
          obscureText: true,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Senha',
            border: const OutlineInputBorder(),
            errorText: state.password.displayError != null ? "Senha inválida!" : null,
          ),
          onChanged: (password) => context.read<SignUpBloc>().add(PasswordSignUpChanged(password: password)),
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
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) => SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: state.isValid ? () => context.read<SignUpBloc>().add(FormSignUpSubmitted()) : null,
            child: state.status.isInProgress
                ? Transform.scale(
                    scale: 0.44,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    'REGISTRA-SE',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        ),
      );
}

class _SignIn extends StatelessWidget {
  const _SignIn();

  @override
  Widget build(BuildContext context) {
    TextStyle defaultText = const TextStyle(color: Colors.black, fontSize: 16);
    TextStyle linkText = const TextStyle(color: TColors.primary, fontSize: 16);

    return SizedBox(
      width: 240,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'Possui uma conta? ', style: defaultText),
            TextSpan(
              text: 'Clique aqui ',
              style: linkText,
              recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(AppRoutes.signIn),
            ),
            TextSpan(text: 'para realizar o login', style: defaultText),
          ],
        ),
      ),
    );
  }
}
