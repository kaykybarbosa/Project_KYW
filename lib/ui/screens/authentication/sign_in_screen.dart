import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/state_management/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:kyw_management/utils/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) => BlocListener<SignInBloc, SignInState>(
        listener: (_, state) {
          if (state.status.isSuccess) {
            Get.offAllNamed(AppRoutes.home);
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Gap(0),

                /// Formulário
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        /// -- Título
                        const MyTitle(title: 'LOGIN'),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /// -- E-mail
                            const _EmailInput(),

                            /// -- Senha
                            const _PasswordInput(),

                            /// -- Esqueceu senha
                            _ForgotPassword(onTap: () => Get.toNamed(AppRoutes.emailForgotPassword)),

                            const Gap(40),

                            /// -- Botão de acesso
                            const _SubmitButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                /// Criar conta
                const _MessageToRegistered()
              ],
            ),
          ),
        ),
      );
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            initialValue: state.email.value,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'E-mail',
              border: const OutlineInputBorder(),
              errorText: state.email.displayError,
            ),
            onChanged: (email) => context.read<SignInBloc>().add(EmailSignInChanged(email: email)),
          ),
        ),
      );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) => TextFormField(
          obscureText: true,
          initialValue: state.password.value,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Senha',
            border: const OutlineInputBorder(),
            errorText: state.password.displayError,
          ),
          onChanged: (password) => context.read<SignInBloc>().add(PasswordSignInChanged(password: password)),
        ),
      );
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onTap,
        child: const Text(
          'Esqueceu a senha ?',
          textAlign: TextAlign.start,
          style: TextStyle(color: TColors.primary),
        ),
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.isValid ? () => context.read<SignInBloc>().add(FormSignInSubmitted()) : null,
            child: state.status.isInProgress
                ? Transform.scale(
                    scale: 0.44,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    'ENTRAR',
                    style: TextStyle(fontSize: TConstants.fontSizeMd),
                  ),
          ),
        ),
      );
}

class _MessageToRegistered extends StatelessWidget {
  const _MessageToRegistered();

  @override
  Widget build(BuildContext context) {
    TextStyle defaultText = const TextStyle(color: Colors.black, fontSize: 16);
    TextStyle linkText = const TextStyle(color: Colors.blue, fontSize: 16);

    return SizedBox(
      width: 260,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Não possui uma conta? ',
              style: defaultText,
            ),
            TextSpan(
              text: 'Clique aqui ',
              style: linkText,
              recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(AppRoutes.signUp),
            ),
            TextSpan(
              text: 'para criar uma',
              style: defaultText,
            ),
          ],
        ),
      ),
    );
  }
}
