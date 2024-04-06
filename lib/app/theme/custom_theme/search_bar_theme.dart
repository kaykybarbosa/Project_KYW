import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TSearchBarTheme {
  static SearchBarThemeData light = const SearchBarThemeData(
    elevation: MaterialStatePropertyAll(0),
    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
    side: MaterialStatePropertyAll(BorderSide(color: TColors.base200)),
    hintStyle: MaterialStatePropertyAll(TextStyle(color: TColors.base300)),
    textStyle: MaterialStatePropertyAll(TextStyle(color: TColors.secondary)),
  );
}
