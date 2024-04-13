import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

abstract class TElevatedButtonTheme {
  static ElevatedButtonThemeData light = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: TConstants.fontSizeLg + 2,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      foregroundColor: TColors.base100,
      backgroundColor: TColors.primary,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs))),
    ),
  );
}
