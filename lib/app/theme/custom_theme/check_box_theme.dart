import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

abstract class TCheckBoxTheme {
  static CheckboxThemeData light = CheckboxThemeData(
    splashRadius: 16,
    side: const BorderSide(color: TColors.base300),
    checkColor: const WidgetStatePropertyAll(TColors.base100),
    overlayColor: WidgetStatePropertyAll(TColors.base200.withOpacity(.5)),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs))),
  );
}
