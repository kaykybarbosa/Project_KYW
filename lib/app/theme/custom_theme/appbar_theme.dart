import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TAppbarTheme {
  static AppBarTheme light = const AppBarTheme(
    elevation: 0,
    backgroundColor: TColors.secondary,
    foregroundColor: TColors.base100,
  );
}
