import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TAppbarTheme {
  static AppBarTheme light = AppBarTheme(
      elevation: 0,
      backgroundColor: TColors.secondary,
      foregroundColor: TColors.base100,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
}
