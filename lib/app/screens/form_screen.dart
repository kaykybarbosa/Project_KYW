import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/validation/validation_password_input.dart';
import 'package:kyw_management/app/widgets/button_main.dart';
import 'package:kyw_management/app/widgets/button_network.dart';
import 'package:kyw_management/app/widgets/my_title.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MyDecorations.backGroundColor,
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.all(30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title the screen
                  MyTitle(
                    title: _isLogin ? 'LOGIN' : 'REGISTER',
                  ),

                  const SizedBox(height: 40),

                  // Form the screen
                  Visibility(
                    visible: !_isLogin,
                    child: CupertinoTextFormFieldRow(
                      controller: _nameController,
                      padding: EdgeInsets.zero,
                      placeholder: 'Nome',
                      placeholderStyle: MyDecorations.placeHolderStyle(),
                      decoration: MyDecorations.inputDecoration(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      style: MyDecorations.inputTextStyle(),
                      validator: (name) {
                        return Validation.validateName(name);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  CupertinoTextFormFieldRow(
                    controller: _emailController,
                    padding: EdgeInsets.zero,
                    keyboardType: TextInputType.emailAddress,
                    placeholder: 'E-mail ou Número',
                    placeholderStyle: MyDecorations.placeHolderStyle(),
                    decoration: MyDecorations.inputDecoration(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    style: MyDecorations.inputTextStyle(),
                    validator: (email) {
                      return Validation.validateEmail(email);
                    },
                  ),
                  const SizedBox(height: 15),
                  CupertinoTextFormFieldRow(
                    controller: _passwordController,
                    padding: EdgeInsets.zero,
                    placeholder: 'Senha',
                    placeholderStyle: MyDecorations.placeHolderStyle(),
                    decoration: MyDecorations.inputDecoration(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: _isLogin ? null : TextInputAction.next,
                    obscureText: true,
                    style: MyDecorations.inputTextStyle(),
                    validator: (password) {
                      if (_isLogin) {
                        return null;
                      }

                      return Validation.validatePassword(password);
                    },
                  ),
                  SizedBox(height: !_isLogin ? 15 : 0),
                  Visibility(
                    visible: !_isLogin,
                    child: CupertinoTextFormFieldRow(
                      controller: _passwordConfirmController,
                      padding: EdgeInsets.zero,
                      placeholder: 'Confirmar Senha',
                      placeholderStyle: MyDecorations.placeHolderStyle(),
                      decoration: MyDecorations.inputDecoration(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      style: MyDecorations.inputTextStyle(),
                      validator: (passwordConfirm) {
                        return Validation.validatePasswordConfirm(
                            passwordConfirm, _passwordController.text);
                      },
                    ),
                  ),

                  // Forgot password
                  Column(
                    children: [
                      Visibility(
                        visible: _isLogin,
                        child: Row(
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => context.push("/forgot-password"),
                              child: const Text(
                                'Esqueceu a senha ?',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: CupertinoColors.link),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: _isLogin ? 0 : 30),

                  // Or continue with
                  Visibility(
                    visible: !_isLogin,
                    child: const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Text(
                              'Ou continue com',
                              style:
                                  TextStyle(color: CupertinoColors.systemGrey),
                            )),
                        Expanded(
                          child: Divider(
                            color: CupertinoColors.inactiveGray,
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: _isLogin ? 0 : 19),

                  // Google + Facebook
                  Visibility(
                    visible: !_isLogin,
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
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Main button the screen
                  ButtonMain(
                    onTap: () {
                      mainButtonClicked();
                    },
                    text: _isLogin ? 'Entrar' : 'Criar Conta',
                  ),

                  const SizedBox(height: 70),

                  // Message to registered or to login
                  SizedBox(
                    width: _isLogin ? 240 : 190,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: _isLogin
                            ? 'Não possui uma conta?'
                            : 'Já tem um conta?',
                        style: MyDecorations.textSpanStyle(),
                        children: [
                          TextSpan(
                            text: ' Clique aqui',
                            style: const TextStyle(color: CupertinoColors.link),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  _isLogin = !_isLogin;

                                  // Cleaning inputs the form
                                  _passwordController.clear();
                                  _nameController.clear();
                                  _passwordConfirmController.clear();
                                });
                              },
                          ),
                          TextSpan(
                            text: _isLogin ? ' para criar uma' : ' para entrar',
                            style: MyDecorations.textSpanStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  mainButtonClicked() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {}
    } else {
      if (!_isLogin) {}
    }
  }
}
