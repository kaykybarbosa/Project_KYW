import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/validation/form_input_validation.dart';
import 'package:kyw_management/app/widgets/button_main.dart';
import 'package:kyw_management/app/widgets/button_network.dart';
import 'package:kyw_management/app/widgets/form_input.dart';
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
                          return Validation.validateName(name);
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    FormInput(
                      placeHolder: 'E-mail ou Número',
                      inputController: _emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (email) {
                        return Validation.validateEmail(email);
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
                        return Validation.validatePassword(
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
                          return Validation.validatePasswordConfirm(
                            passwordConfirm: passwordConfirm,
                            password: _passwordController.text,
                          );
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
                                onPressed: () =>
                                    context.push("/forgot-password"),
                                child: const Text(
                                  'Esqueceu a senha ?',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: CupertinoColors.link),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: _isLogin ? 0 : 30),

                    // Or continue with
                    Visibility(
                      visible: !_isLogin,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: CupertinoColors.separator,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                            child: Text(
                              'Ou continue com',
                              style:
                                  TextStyle(color: CupertinoColors.systemGrey),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: CupertinoColors.separator,
                            ),
                          ),
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
                                style: const TextStyle(
                                    color: CupertinoColors.link),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });

                                    // Cleaning fields the form
                                    if ((Validation.validateEmail(
                                            _emailController.text)) !=
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

  mainButtonClicked() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        context.go('/projects');
      }
    } else {
      _formKey.currentState!.reset();
      if (!_isLogin) {}
    }
  }
}
