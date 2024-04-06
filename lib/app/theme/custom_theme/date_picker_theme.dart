import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TDatePickerTheme {
  static DatePickerThemeData light = const DatePickerThemeData(
    headerBackgroundColor: TColors.secondary,
    headerForegroundColor: TColors.base200,
    backgroundColor: TColors.base200,
  );
}
