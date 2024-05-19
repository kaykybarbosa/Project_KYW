import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

abstract class TChipTheme {
  static ChipThemeData light = ChipThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TConstants.cardRadiusLg),
      side: const BorderSide(color: Colors.transparent),
    ),
    color: const WidgetStatePropertyAll(TColors.base200),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  );
}
