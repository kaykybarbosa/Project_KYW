import 'package:flutter/material.dart';
import 'package:kyw_management/app/theme/custom_theme/appbar_theme.dart';
import 'package:kyw_management/app/theme/custom_theme/check_box_theme.dart';
import 'package:kyw_management/app/theme/custom_theme/chip_theme.dart';
import 'package:kyw_management/app/theme/custom_theme/color_scheme.dart';
import 'package:kyw_management/app/theme/custom_theme/date_picker_theme.dart';
import 'package:kyw_management/app/theme/custom_theme/elevated_button_theme.dart';
import 'package:kyw_management/app/theme/custom_theme/input_decoration_theme.dart';
import 'package:kyw_management/app/theme/custom_theme/search_bar_theme.dart';
import 'package:kyw_management/app/theme/custom_theme/tab_bar_theme.dart';
import 'package:kyw_management/app/theme/custom_theme/text_theme.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: TColorScheme.light,
        appBarTheme: TAppbarTheme.light,
        elevatedButtonTheme: TElevatedButtonTheme.light,
        inputDecorationTheme: TInputDecorationTheme.light,
        searchBarTheme: TSearchBarTheme.light,
        checkboxTheme: TCheckBoxTheme.light,
        datePickerTheme: TDatePickerTheme.light,
        chipTheme: TChipTheme.light,
        tabBarTheme: TTabBarTheme.light,
        dividerColor: TColors.base200,
        dividerTheme: const DividerThemeData(color: TColors.base200, space: 0),
        popupMenuTheme: const PopupMenuThemeData(color: TColors.base100),
        textTheme: TTextTheme.light,
        shadowColor: TColors.base900,
        listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(color: TColors.secondary),
          iconColor: TColors.secondary,
        ),
        iconTheme: const IconThemeData(
          color: TColors.base100,
          size: TConstants.iconMd - 2,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TConstants.cardRadiusXs)),
          ),
        ),
      );
}
