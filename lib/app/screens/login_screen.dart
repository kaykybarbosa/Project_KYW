import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/screens/widgets/button_main.dart';
import 'package:kyw_management/app/screens/widgets/input_field.dart';
import 'package:kyw_management/app/screens/widgets/my_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const MyTitle(title: 'LOGIN'),
            Column(
              children: [
                const InputField(placeHolder: 'E-mail ou Número'),
                InputField(
                    placeHolder: 'Senha',
                    isPassword: true,
                    validation: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? const Text('Digite um e-mail válido')
                            : null),
                SizedBox(
                  width: 375,
                  child: Row(
                    children: [
                      CupertinoButton(
                          onPressed: () => context.push("/forgot-password"),
                          child: const Text('Esqueceu a senha ?'))
                    ],
                  ),
                ),
              ],
            ),
            ButtonMain(
              onTap: () {
                var form = formKey.currentState!;

                if (form.validate()) {
                  context.go("/projects");
                }
              },
              text: 'Entrar',
            ),
            SizedBox(
                width: 240,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Não possui uma conta?',
                    style: const TextStyle(
                        color: CupertinoColors.black, fontSize: 18),
                    children: [
                      TextSpan(
                          text: ' Clique aqui',
                          style: const TextStyle(color: CupertinoColors.link),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => context.pushReplacement('/login-test')),
                      const TextSpan(text: ' para criar uma'),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
