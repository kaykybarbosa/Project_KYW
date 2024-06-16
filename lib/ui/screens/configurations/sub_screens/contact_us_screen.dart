import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/widgets/my_icon_drag.dart';
import 'package:kyw_management/ui/widgets/my_text_field.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final valueMax = 10;
  final valueMin = 3;
  int maxLines = 3;

  void _setHeightInput(double? value) {
    setState(() {
      if (value != null) {
        if (value > 0 && maxLines != valueMax) {
          maxLines += 1;
        } else if (value < 0 && maxLines != valueMin) {
          maxLines -= 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Contate-nos')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Gap(10),

                      /// Descrição
                      MyTextFormField(
                        keyboardType: TextInputType.multiline,
                        hintText: 'Descrição',
                        maxLines: maxLines,
                      ),

                      /// Ícone
                      MyIconDrag(
                        isDrag: maxLines == valueMax,
                        onVerticalDragUpdate: _setHeightInput,
                      ),

                      const Gap(60.0),

                      /// Card com as informações
                      const _InformationsCard(),
                    ],
                  ),
                ),
              ),

              /// Enviar mensagem
              const _SubmitButton(),
            ],
          ),
        ),
      );
}

class _InformationsCard extends StatelessWidget {
  const _InformationsCard();

  final String info =
      'Estamos aqui para ajudar! Se você tiver alguma dúvida, comentário ou precisa de assistência, por favor, entre em contato conosco. Preencha o formulário abaixo e responderemos o mais rápido possível.';

  final String subInfo = 'Sua responsta irá aparecer na aba de notificações.';

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 7.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(TConstants.cardRadiusXs - 5),
          boxShadow: const [
            BoxShadow(
              color: TColors.base200,
              blurRadius: TConstants.blurRadius,
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: TColors.base100,
            border: Border.all(color: TColors.base200),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(TConstants.cardRadiusXs - 5),
              bottomRight: Radius.circular(TConstants.cardRadiusXs - 5),
            ),
          ),
          child: Column(
            children: <Widget>[
              /// Informação
              Text(
                info,
                style: const TextStyle(fontSize: TConstants.fontSizeMd),
              ),
              const Gap(15),

              /// Descrição
              Text(
                subInfo,
                style: const TextStyle(
                  fontSize: TConstants.fontSizeMd,
                  color: TColors.primary,
                ),
              )
            ],
          ),
        ),
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SubmitButton(
          label: 'Enviar mensagem',
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: TColors.success,
          ),
        ),
      );
}
