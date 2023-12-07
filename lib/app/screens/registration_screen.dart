import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/blocs/sign_in_export.dart';
import '../enums/my_routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<SignInBloc>().add(NameSignUpUnfocused());
        // FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignInBloc>().add(EmailSignInUnfocused());
        // FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SignInBloc>().add(PasswordSignInUnfocused());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: state.name.value,
                  focusNode: _nameFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: const OutlineInputBorder(),
                    errorText: state.name.displayError != null
                        ? "Por favor, inforeme um nome"
                        : null,
                  ),
                  onChanged: (name) => context
                      .read<SignInBloc>()
                      .add(NameSignUpChanged(name: name)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: state.email.value,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    hintText: 'E-mail ou Número',
                    border: const OutlineInputBorder(),
                    errorText: state.email.displayError != null
                        ? "Por favor, informe um e-mail válido!"
                        : null,
                  ),
                  onChanged: (email) => context.read<SignInBloc>().add(
                        EmailSignInChanged(
                          email: email,
                          formType: FormType.signUp.name,
                        ),
                      ),
                );
              },
            ),
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.password.value,
                focusNode: _passwordFocusNode,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  border: const OutlineInputBorder(),
                  errorText: state.password.displayError != null
                      ? "Sua senha deve conter pelo menos 6 caracteres!"
                      : null,
                ),
                onChanged: (password) => context.read<SignInBloc>().add(
                      PasswordSignInChanged(
                        password: password,
                        formType: FormType.signUp.name,
                      ),
                    ),
              );
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context
                  .read<SignInBloc>()
                  .add(FormSignInSubmitted(formType: FormType.signUp.name)),
              child: const Text(
                'REGISTRA-SE',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            width: 260,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Não possui uma conta? ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: 'Clique aqui ',
                    style: TextStyle(color: Colors.black),
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => GoRouter.of(context).push(MyRoutes.signIn),
                  ),
                  TextSpan(
                      text: 'para criar uma',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
