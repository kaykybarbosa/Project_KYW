import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/screens/widgets/button_main.dart';
import 'package:kyw_management/app/screens/widgets/button_network.dart';
import 'package:kyw_management/app/screens/widgets/input_field.dart';
import 'package:kyw_management/app/screens/widgets/my_title.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const MyTitle(title: 'REGISTER'),
                const SizedBox(height: 60),
                const InputField(placeHolder: 'Nome'),
                const SizedBox(height: 20),
                const InputField(placeHolder: 'E-mail ou Número'),
                const SizedBox(height: 20),
                const InputField(
                  placeHolder: 'Senha',
                  isPassword: true,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonNetwork(
                        text: 'Google',
                        image: Image.asset(
                          'assets/Google.webp',
                          width: 30,
                        ),
                        width: 140,
                      ),
                      ButtonNetwork(
                        text: 'Facebook',
                        image: Image.asset(
                          'assets/Facebook-logo.webp',
                          width: 34,
                        ),
                        width: 160,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ButtonMain(
                  onTap: () {},
                  text: 'Registre-se',
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 200,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Já tem uma conta?',
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
                                context.pushReplacement("/login");
                              }),
                        const TextSpan(text: ' para entrar'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
