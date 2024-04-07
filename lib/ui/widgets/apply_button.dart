import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

class ApplyButtom extends StatelessWidget {
  const ApplyButtom({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            TTexts.apply,
            style: TextStyle(
              color: TColors.base100,
              fontSize: TConstants.fontSizeLg + 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}
