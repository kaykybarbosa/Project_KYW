import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TCheckBoxTheme {
  static CheckboxThemeData light = const CheckboxThemeData(
    splashRadius: 16,
    checkColor: MaterialStatePropertyAll(TColors.base100),
    overlayColor: MaterialStatePropertyAll(TColors.base300),
  );
}
