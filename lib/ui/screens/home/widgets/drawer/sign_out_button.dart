import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: TColors.warn.withOpacity(.24),
          borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// Ícone
            Icon(
              TIcons.singOut,
              color: TColors.warn,
              size: TConstants.iconMd - 2,
            ),
            Gap(15.0),

            /// Sair
            Text(
              TTexts.singOut,
              style: TextStyle(
                color: TColors.warn,
                fontSize: TConstants.fontSizeLg + 3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
