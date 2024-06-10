import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TDatePickerTheme {
  static DatePickerThemeData light = DatePickerThemeData(
    backgroundColor: TColors.base100,
    headerBackgroundColor: TColors.secondary,
    headerForegroundColor: TColors.base100,
    weekdayStyle: const TextStyle(color: TColors.base300),
    dayForegroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        final isSelected = states.contains(WidgetState.selected);

        return isSelected ? TColors.base100 : TColors.secondary;
      },
    ),
  );
}
