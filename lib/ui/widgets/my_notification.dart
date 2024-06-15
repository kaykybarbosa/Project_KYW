import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class MyNotification extends StatelessWidget {
  const MyNotification({
    super.key,
    required String message,
    required String time,
  })  : _message = message,
        _time = time;

  final String _message;
  final String _time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: TConstants.defaultMargin,
        vertical: 15.0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              /// Mensagem
              Expanded(
                child: Text(
                  _message,
                  style: const TextStyle(fontSize: TConstants.fontSizeLg),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),

          const SizedBox(height: 10.0),

          /// Data da mensagem e Compatilhamento
          Row(
            children: [
              /// -- Mensagem
              Text(
                _time,
                style: const TextStyle(
                  color: TColors.base200,
                  fontSize: TConstants.fontSizeMd - 1,
                ),
              ),

              /// -- Compartilhar
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      /// -- Ícone
                      Icon(
                        TIcons.share,
                        color: TColors.primary,
                        size: TConstants.iconSm,
                      ),
                      Gap(3),

                      /// -- Nome
                      Text(
                        TTexts.toShared,
                        style: TextStyle(
                          color: TColors.primary,
                          fontSize: TConstants.fontSizeMd,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
