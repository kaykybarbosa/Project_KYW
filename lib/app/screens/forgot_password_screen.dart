import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/validation/validation_password_input.dart';
import 'package:kyw_management/app/widgets/button_main.dart';
import 'package:kyw_management/app/widgets/input_email_valid.dart';
import 'package:kyw_management/app/widgets/my_title.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _sendCode = false;

  final _codeTest = '123456';

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
                children: [
                  // title the screen
                  const MyTitle(title: 'FORGOT PASSWORD'),

                  const SizedBox(height: 70),

                  // Text informing what to do
                  Row(
                    mainAxisAlignment: _sendCode
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Text(
                        _sendCode
                            ? 'Digite o código que enviamos para seu e-mail'
                            : 'Digite o e-mail cadastrado em sua conta',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.systemGrey,
                            fontSize: _sendCode ? 15 : 17),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Input the Email
                  Visibility(
                    visible: !_sendCode,
                    child: const InputEmailValid(
                      placeHolder: 'E-mail',
                    ),
                  ),

                  // Input the Code
                  Visibility(
                    visible: _sendCode,
                    child: SizedBox(
                      width: 210,
                      child: CupertinoTextFormFieldRow(
                        style: const TextStyle(
                            color: CupertinoColors.black, fontSize: 23),
                        decoration: MyDecorations.inputDecoration(
                            color: CupertinoColors.activeBlue),
                        placeholder: '* * *  -  * * *',
                        placeholderStyle: MyDecorations.inputTextStyle(),
                        textAlign: TextAlign.center,
                        validator: (code) {
                          return Validation.validateCode(code, _codeTest);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 150),

                  // Main button the screen
                  ButtonMain(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          // if are in authenticate Code, go to chage-password-screen
                          if (_sendCode) {
                            context.push('/change-password');
                          }

                          _sendCode = !_sendCode;
                        });
                      }
                    },
                    text: _sendCode ? 'Avançar' : 'Receber código',
                  ),

                  const SizedBox(height: 70),

                  // Message to login, case have account
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 190,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Já tem um conta?',
                          style: MyDecorations.textSpanStyle(),
                          children: [
                            TextSpan(
                              text: ' Clique aqui',
                              style:
                                  const TextStyle(color: CupertinoColors.link),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.push('/');
                                },
                            ),
                            TextSpan(
                                text: ' para entrar',
                                style: MyDecorations.textSpanStyle()),
                          ],
                        ),
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
}
