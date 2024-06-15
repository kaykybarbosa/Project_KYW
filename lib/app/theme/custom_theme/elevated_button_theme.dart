import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

abstract class TElevatedButtonTheme {
  static ElevatedButtonThemeData light = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.base100,
      shadowColor: Colors.transparent,
      backgroundColor: TColors.primary,
      disabledForegroundColor: TColors.base200.withOpacity(.8),
      disabledBackgroundColor: TColors.base120,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
      ),
      textStyle: const TextStyle(
        fontSize: TConstants.fontSizeSm + 2,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
