import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TInputDecorationTheme {
  static InputDecorationTheme light = const InputDecorationTheme(
    filled: true,
    hintStyle: TextStyle(color: TColors.base150),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: TColors.base150)),
    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
    fillColor: TColors.base100,
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: TColors.primary)),
  );
}
