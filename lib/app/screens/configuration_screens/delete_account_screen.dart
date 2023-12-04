import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';
import 'package:kyw_management/app/widgets/configuration_screen/account_button_main.dart';
import 'package:kyw_management/app/widgets/configuration_screen/account_input.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String titleInfo = 'O que acontecerá quando você excluir a conta:';
    String firstInfo =
        '- Todos os seus dados vinculados a esta conta serão apagados permanentemente.';
    String secoundInfo = '- Você sairá de todos os projetos.';
    String thirdInfo = '- Todo o seu histórico será deletado.';

    String textEnterPhoneOrEmail =
        'Para excluir sua conta, digite seu número de telefone ou e-mail abaixo:';

    final screenSize = MediaQuery.of(context).size;

    return MyScaffold(
      arrowBack: () {
        context.pop(context);
      },
      title: 'Deletar conta',
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: (screenSize.height / 1.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card the infomation
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: CupertinoTheme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // First part
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.triangleExclamation,
                                color: CupertinoColors.systemYellow,
                                size: 45.0,
                              ),

                              const SizedBox(width: 20.0),

                              // Message [Will happen case continues]
                              Expanded(
                                child: Text(
                                  titleInfo,
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'source',
                                    color: CupertinoColors.systemYellow,
                                  ),
                                ),
                              )
                            ],
                          ),

                          // Information abount what will happen
                          _informations(firstInfo),
                          _informations(secoundInfo),
                          _informations(thirdInfo),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50.0),

                    // Text the enter phone or email
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        textEnterPhoneOrEmail,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Input for enter phone or email
                    AccountInput(
                      placeHolder: 'E-mail ou Telefone',
                      validator: () {},
                    ),
                  ],
                ),

                // Button delete account
                AccountButtonMain(
                  isDanger: true,
                  label: 'Deletar Conta',
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Padding _informations(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      text,
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
