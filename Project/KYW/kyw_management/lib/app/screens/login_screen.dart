import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/screens/widgets/button_main.dart';
import 'package:kyw_management/app/screens/widgets/input_field.dart';
import 'package:kyw_management/app/screens/widgets/my_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyTitle(title: 'LOGIN'),
              const SizedBox(height: 60),
              const InputField(placeHolder: 'E-mail ou Número'),
              const SizedBox(height: 20),
              const InputField(
                placeHolder: 'Senha',
                isPassword: true,
              ),
              Row(
                children: [
                  const SizedBox(width: 16),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                        onPressed: () {
                          context.push("/forgot-password");
                        },
                        child: const Text('Esqueceu a senha ?')),
                  )
                ],
              ),
              const SizedBox(height: 50),
              ButtonMain(
                onTap: () {
                  context.pushReplacement("/projects");
                },
                text: 'Entrar',
              ),
              const SizedBox(height: 40),
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
                          style: const TextStyle(
                              color: CupertinoColors.link,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushReplacement('/register');
                            }),
                      const TextSpan(text: ' para criar uma'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
