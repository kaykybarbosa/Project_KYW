import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/validation/validation_password_input.dart';
import 'package:kyw_management/app/widgets/button_main.dart';
import 'package:kyw_management/app/widgets/my_title.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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

              // text the input password
              const Row(
                children: [
                  Text(
                    'Entre com sua nova senha',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15.0),

              // input the password
              CupertinoTextFormFieldRow(
                controller: _newPasswordController,
                padding: EdgeInsets.zero,
                placeholder: 'New Password',
                placeholderStyle: MyDecorations.placeHolderStyle(),
                decoration: MyDecorations.inputDecoration(),
                style: MyDecorations.inputTextStyle(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) {
                  return Validation.validatePassword(password);
                },
              ),

              const SizedBox(height: 20.0),

              // text the input password confirm
              const Row(
                children: [
                  Text(
                    'Confirme a senha',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15.0),

              // input the password confirm
              CupertinoTextFormFieldRow(
                controller: _newPasswordConfirmController,
                padding: EdgeInsets.zero,
                placeholder: 'Confirme a nova senha',
                placeholderStyle: MyDecorations.placeHolderStyle(),
                decoration: MyDecorations.inputDecoration(),
                style: MyDecorations.inputTextStyle(),
                validator: (passwordConfirm) {
                  return Validation.validatePasswordConfirm(
                      passwordConfirm, _newPasswordController.text);
                },
              ),

              const SizedBox(height: 100),

              // main button for conclud change password
              ButtonMain(text: 'Concluir', onTap: () {}),

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
                        const TextSpan(
                          text: 'Clique aqui',
                          style: TextStyle(
                            color: CupertinoColors.systemRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: ' se você não deseja criar uma nova senha',
                          style: MyDecorations.textSpanStyle(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push('/');
                            },
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
    );
  }
}
