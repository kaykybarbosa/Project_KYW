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
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MyTitle(title: 'LOGIN'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const InputField(placeHolder: 'E-mail ou Número'),
                  const SizedBox(height: 20),
                  const InputField(
                    placeHolder: 'Senha',
                    isPassword: true,
                  ),
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
            ],
          ),
          ButtonMain(
            onTap: () => context.go("/projects"),
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
                          ..onTap = () => context.pushReplacement('/register')),
                    const TextSpan(text: ' para criar uma'),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
