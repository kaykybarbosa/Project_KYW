import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TColorScheme {
  static ColorScheme light = const ColorScheme.light(
    surface: TColors.base100,
    primary: TColors.secondary,
    error: TColors.warn,
    onSurface: TColors.base300,
  );
}
