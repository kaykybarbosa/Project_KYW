import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/validation/input_validator.dart';
import 'package:kyw_management/app/widgets/button_main.dart';
import 'package:kyw_management/app/widgets/change_password_screen/input_of_title.dart';
import 'package:kyw_management/app/widgets/form_input.dart';
import 'package:kyw_management/app/widgets/my_title.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  // Title the screen
                  const MyTitle(title: 'CHANGE YOUR PASSWORD'),

                  const SizedBox(height: 70.0),

                  // text the input new password
                  const InputOfTitle(label: 'Entre com sua nova senha'),

                  const SizedBox(height: 15.0),

                  // input the new password
                  FormInput(
                    placeHolder: 'Nova Senha',
                    inputController: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    validator: (value) {
                      return InputValidator.validatePassword(password: value);
                    },
                  ),

                  const SizedBox(height: 20.0),

                  // text the input new password confirm
                  const InputOfTitle(label: 'Confirme a senha'),

                  const SizedBox(height: 15.0),

                  // input the new password confirm
                  FormInput(
                    placeHolder: 'Confirme a nova senha',
                    inputController: _passwordConfirmController,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (passwordConfirm) {
                      return InputValidator.validatePasswordConfirm(
                          password: passwordConfirm,
                          passwordConfirm: _passwordController.text);
                    },
                  ),

                  const SizedBox(height: 100),

                  // main button for conclud change password
                  ButtonMain(
                      text: 'Concluir',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                        } else {
                          _formKey.currentState!.reset();
                        }
                      }),

                  const SizedBox(height: 70.0),

                  // message to don't create new password
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 260,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Clique aqui',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Go to HomeApp
                                  context.go(MyRoutes.home);
                                },
                              style: const TextStyle(
                                color: CupertinoColors.systemRed,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            TextSpan(
                              text: ' se você não deseja criar uma nova senha',
                              style: MyDecorations.textSpanStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
