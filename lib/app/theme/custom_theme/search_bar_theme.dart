import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TSearchBarTheme {
  static SearchBarThemeData light = const SearchBarThemeData(
    elevation: WidgetStatePropertyAll(0),
    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
    side: WidgetStatePropertyAll(BorderSide(color: TColors.base200)),
    hintStyle: WidgetStatePropertyAll(TextStyle(color: TColors.base300)),
    textStyle: WidgetStatePropertyAll(TextStyle(color: TColors.secondary)),
  );
}
