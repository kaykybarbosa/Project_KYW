import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/screens/widgets/button_main.dart';
import 'package:kyw_management/app/screens/widgets/input_field.dart';
import 'package:kyw_management/app/screens/widgets/my_title.dart';

class ForgotPassoword extends StatelessWidget {
  const ForgotPassoword({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MyTitle(title: 'FORGOT PASSWORD'),
          const SizedBox(
            width: 350,
            height: 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Digite o e-mail cadastrado na sua conta',
                    style: TextStyle(
                        color: Color.fromRGBO(50, 58, 71, 1), fontSize: 20),
                  ),
                ),
                InputField(placeHolder: 'E-mail'),
              ],
            ),
          ),
          Column(
            children: [
              ButtonMain(
                onTap: () {},
                text: 'Recuperar senha',
              ),
              GestureDetector(
                onTap: () {
                  context.pushReplacement('/login');
                },
                child: const SizedBox(
                    width: 350,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Voltar',
                          style: TextStyle(fontSize: 18),
                        ))),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
