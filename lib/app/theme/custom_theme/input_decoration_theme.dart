import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

abstract class TInputDecorationTheme {
  static InputDecorationTheme light = InputDecorationTheme(
    filled: true,
    fillColor: TColors.base100,
    errorMaxLines: 2,
    hintStyle: const TextStyle(color: TColors.base150),
    contentPadding: const EdgeInsets.all(12),
    border: const OutlineInputBorder(),
    suffixIconColor: TColors.base200,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: TColors.base150),
      borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: TColors.base150),
      borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: TColors.base150.withOpacity(.7), width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: TColors.warn),
      borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: TColors.warn, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
    ),
  );
}
