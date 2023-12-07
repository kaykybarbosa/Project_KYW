import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/validation/input_validator.dart';
import 'package:kyw_management/app/widgets/button_main.dart';
import 'package:kyw_management/app/widgets/form_input.dart';
import 'package:kyw_management/app/widgets/form_screen/continue_with.dart';
import 'package:kyw_management/app/widgets/form_screen/forgot_password_button.dart';
import 'package:kyw_management/app/widgets/form_screen/sign_google_facebook.dart';
import 'package:kyw_management/app/widgets/my_title.dart';

import '../../domain/blocs/sign_in_export.dart';

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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MyDecorations.backGroundColor,
      child: SafeArea(
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
                      child: FormInput(
                        placeHolder: 'Nome',
                        inputController: _nameController,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (name) {
                          return InputValidator.validateName(name);
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return FormInput(
                          placeHolder: 'E-mail ou Número',
                          inputController: _emailController,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (email) {
                            return InputValidator.validateEmail(email: email);
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    FormInput(
                      placeHolder: 'Senha',
                      inputController: _passwordController,
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: _isLogin ? null : TextInputAction.next,
                      validator: (password) {
                        return InputValidator.validatePassword(
                            password: password, isLogin: _isLogin);
                      },
                    ),

                    SizedBox(height: !_isLogin ? 15 : 0),

                    Visibility(
                      visible: !_isLogin,
                      child: FormInput(
                        placeHolder: 'Confirmar senha',
                        inputController: _passwordConfirmController,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (passwordConfirm) {
                          return InputValidator.validatePasswordConfirm(
                            passwordConfirm: passwordConfirm,
                            password: _passwordController.text,
                          );
                        },
                      ),
                    ),

                    // Forgot password
                    Visibility(
                      visible: _isLogin,
                      child: ForgotPasswordButton(
                        onTap: () {
                          context.push(MyRoutes.forgotPassword);
                        },
                      ),
                    ),

                    SizedBox(height: _isLogin ? 0 : 30),

                    // Or continue with
                    Visibility(
                      visible: !_isLogin,
                      child: const ContinueWith(),
                    ),

                    SizedBox(height: _isLogin ? 0 : 19),

                    // Google + Facebook
                    Visibility(
                      visible: !_isLogin,
                      child: const SignGoogleFacebook(),
                    ),

                    const SizedBox(height: 40),

                    // Main button the screen
                    ButtonMain(
                      onTap: () {
                        _mainButtonClicked();
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
                                style: const TextStyle(
                                    color: CupertinoColors.link),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });

                                    // Cleaning fields the form
                                    if ((InputValidator.validateEmail(
                                            email: _emailController.text)) !=
                                        null) {
                                      _emailController.clear();
                                    }
                                    _nameController.clear();
                                    _passwordController.clear();
                                    _passwordConfirmController.clear();
                                  },
                              ),
                              TextSpan(
                                text: _isLogin
                                    ? ' para criar uma'
                                    : ' para entrar',
                                style: MyDecorations.textSpanStyle(),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _mainButtonClicked() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        context.go(MyRoutes.home);
      }
    } else {
      _formKey.currentState!.reset();
      if (!_isLogin) {}
    }
  }
}
