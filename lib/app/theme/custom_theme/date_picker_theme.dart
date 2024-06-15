import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TDatePickerTheme {
  static DatePickerThemeData light = DatePickerThemeData(
    backgroundColor: TColors.base120,
    headerBackgroundColor: TColors.secondary,
    headerForegroundColor: TColors.base100,
    weekdayStyle: const TextStyle(color: TColors.base300),
    dayForegroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        Color color = TColors.secondary;

        if (states.contains(WidgetState.disabled)) {
          color = TColors.base150;
        }
        if (states.contains(WidgetState.selected)) {
          color = TColors.base150;
        }

        return color;
      },
    ),
  );
}
