import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/enums/my_route.dart';
import 'package:kyw_management/app/validation/form_input_validation.dart';
import 'package:kyw_management/app/widgets/button_main.dart';
import 'package:kyw_management/app/widgets/form_input.dart';
import 'package:kyw_management/app/widgets/my_title.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _codeTest = '123456';
  BoxDecoration myInputDecoration =
      MyDecorations.inputDecoration(borderColor: CupertinoColors.activeBlue);
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _codeController = TextEditingController();

  bool _sendCode = false;

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
                  children: [
                    // Title the screen
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
                            fontSize: _sendCode ? 15 : 17,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Input the Email
                    Visibility(
                      visible: !_sendCode,
                      child: FormInput(
                        placeHolder: 'E-mail',
                        inputController: _emailController,
                        textInputType: TextInputType.emailAddress,
                        validator: (email) {
                          return Validation.validateEmail(email);
                        },
                      ),
                    ),

                    // Input the Code
                    Visibility(
                      visible: _sendCode,
                      child: SizedBox(
                        width: 210,
                        child: inputFieldCode(),
                      ),
                    ),

                    const SizedBox(height: 50),

                    Visibility(
                      visible: _isLoading,
                      child: const CupertinoActivityIndicator(
                        radius: 20.0,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),

                    const SizedBox(height: 150),

                    // Main button the screen
                    ButtonMain(
                      onTap: () async {
                        mainButtonClicked();
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
                                style: const TextStyle(
                                    color: CupertinoColors.link),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push(MyRoute.form);
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
      ),
    );
  }

  void mainButtonClicked() async {
    /// Shows the progress circle
    /// if the user already request the code
    ///
    if (_sendCode && _codeController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        /// If the API is sent authenticate Code
        /// go to chage-password-screen
        ///
        if (_sendCode) {
          _codeController.clear();
          context.push('/change-password');
        }

        _sendCode = !_sendCode;
      });
    } else {
      /// If the form is not valid, and API sent the authentication code
      /// show 'border' the [inputTheCode] in red
      if (_sendCode) {
        setState(() {
          myInputDecoration = MyDecorations.inputDecoration(
            borderColor: CupertinoColors.systemRed,
            isActice: true,
          );
        });
      } else {
        _formKey.currentState!.reset();
      }
    }
  }

  CupertinoTextFormFieldRow inputFieldCode() {
    return CupertinoTextFormFieldRow(
      placeholder: '* * *  -  * * *',
      controller: _codeController,
      textAlign: TextAlign.center,
      padding: EdgeInsets.zero,
      decoration: myInputDecoration,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(color: CupertinoColors.black, fontSize: 23),
      placeholderStyle: MyDecorations.placeHolderStyle(
        placeHolderColor: CupertinoTheme.of(context).primaryColor,
        fontSize: 23,
      ),
      onTap: () {
        setState(() {
          myInputDecoration = MyDecorations.inputDecoration(
            borderColor: CupertinoColors.activeBlue,
            isActice: true,
          );

          _formKey.currentState!.reset();
        });
      },
      onEditingComplete: () {
        setState(() {
          myInputDecoration = MyDecorations.inputDecoration(
            borderColor: CupertinoColors.activeBlue,
            isActice: false,
          );
        });
      },
      validator: (code) {
        return Validation.validateCode(
          code: code,
          confirmCode: _codeTest,
        );
      },
    );
  }
}
