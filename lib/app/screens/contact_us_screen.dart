import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final String info =
      'Estamos aqui para ajudar! Se você tiver alguma dúvida, comentário ou precisa de assistência, por favor, entre em contato conosco. Preencha o formulário abaixo e responderemos o mais rápido possível.';

  final String subInfo = 'Sua responsta irá aparecer na aba de notificações.';

  int heightInput = 5;

  void _setHeightInput(double? value) {
    setState(() {
      if (value != null) {
        if (value > 0 && heightInput != 25) {
          heightInput += 1;
        } else if (value < 0 && heightInput != 5) {
          heightInput -= 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      arrowBack: () {
        context.pop(context);
      },
      title: 'Contate-nos',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Input the description
              CupertinoTextFormFieldRow(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                  border: Border.all(
                      color: CupertinoTheme.of(context).primaryColor),
                ),
                padding: EdgeInsets.zero,
                placeholder: 'Descrição',
                maxLines: heightInput,
              ),

              // Icon for change height the [InputDescription]
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 25.0),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.activeBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.anglesDown,
                        size: 18.0,
                        color: CupertinoColors.white,
                      )
                    ],
                  ),
                ),
                onVerticalDragUpdate: (onLong) {
                  _setHeightInput(onLong.primaryDelta);
                },
              ),

              const SizedBox(height: 60.0),

              // Card the informations
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const [
                    BoxShadow(
                      color: CupertinoColors.systemGrey,
                      spreadRadius: 0.5,
                      blurRadius: 4.0,
                    )
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    border: Border.all(color: CupertinoColors.systemGrey3),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: Column(
                    children: [
                      Text(
                        info,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 18.3),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        subInfo,
                        style: const TextStyle(
                          fontSize: 17.0,
                          color: CupertinoColors.systemBlue,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 140.0),

              // Button send message
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: const Color(0xFF06AC93),
                  child: const Text(
                    'Enviar Mensagem',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: CupertinoColors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
