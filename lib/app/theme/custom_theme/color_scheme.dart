import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TColorScheme {
  static ColorScheme light = ColorScheme.light(
    background: TColors.base100.withOpacity(.8),
    primary: TColors.primary,
  );
}
