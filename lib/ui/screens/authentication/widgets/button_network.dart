import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/utils/colors.dart';

class ButtonNetwork extends StatelessWidget {
  const ButtonNetwork({super.key, required this.text, required this.image, this.width = 160});

  final String text;
  final Image image;
  final double? width;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
            border: Border.all(color: TColors.primary, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              /// Imagem
              image,

              /// Label
              Text(
                text,
                style: const TextStyle(
                  fontSize: TConstants.fontSizeMd,
                  color: CupertinoColors.black,
                ),
              )
            ],
          ),
        ),
      );
}
