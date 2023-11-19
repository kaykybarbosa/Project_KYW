import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({super.key});

  @override
  State<LoginTest> createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            CupertinoFormSection(
              margin: const EdgeInsets.all(15),
              header: const Text(
                'Conta',
                style: TextStyle(fontSize: 17),
              ),
              children: [
                CupertinoTextFormFieldRow(
                    textInputAction: TextInputAction.next,
                    placeholder: 'E-mail ou Número',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Digite um e-mail válido'
                            : null),
                CupertinoTextFormFieldRow(
                    obscureText: true,
                    placeholder: 'Senha',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Digite uma senha válida';
                      } else if (password.length < 6) {
                        return 'A senha deve conter 6 caracteres.';
                      } else {
                        return null;
                      }
                    }),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(15),
              child: CupertinoButton.filled(
                child: const Text('Entrar'),
                onPressed: () {
                  var form = formKey.currentState!;

                  if (form.validate()) {
                    print('Boa garoto');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
