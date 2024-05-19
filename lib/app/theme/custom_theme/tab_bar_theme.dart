import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

abstract class TTabBarTheme {
  static TabBarTheme light = const TabBarTheme(
    unselectedLabelColor: TColors.base100,
    indicatorColor: TColors.base100,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: TextStyle(color: TColors.base100, fontSize: TConstants.fontSizeLg),
    overlayColor: WidgetStatePropertyAll(TColors.base200),
  );
}
