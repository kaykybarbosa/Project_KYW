import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TAppbarTheme {
  static AppBarTheme light = AppBarTheme(
      elevation: 0,
      titleTextStyle: GoogleFonts.roboto(fontSize: TConstants.fontSizeLg),
      backgroundColor: TColors.secondary,
      foregroundColor: TColors.base100,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
}
