import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/validation/input_validator.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';
import 'package:kyw_management/app/widgets/configuration_screen/account_input.dart';

class TwoStepVerificationScreen extends StatefulWidget {
  const TwoStepVerificationScreen({super.key});

  @override
  State<TwoStepVerificationScreen> createState() =>
      _TwoStepVerificationScreenState();
}

class _TwoStepVerificationScreenState extends State<TwoStepVerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  String info =
      'Para garantir a segurança da sua conta, estamos aplicando uma camada adicional de proteção. Este processo adiciona uma barreira vital contra acessos não autorizados e mantém seus dados pessoais seguros.';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      arrowBack: () {
        context.pop(context);
      },
      title: 'Confirmação em duas etapas',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text for enter email
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Insira seu e-mail',
                    style: TextStyle(fontSize: 19.0),
                  ),
                ),

                // Input for email
                AccountInput(
                  placeHolder: 'E-mail',
                  validator: (email) {
                    return InputValidator.validateEmail(email: email);
                  },
                ),

                // Message the info
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    info,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),

                const SizedBox(height: 300),

                // Button enable verification
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: const Color(0xFF06AC93),
                    child: const Text(
                      'Confirmar Verificação',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
