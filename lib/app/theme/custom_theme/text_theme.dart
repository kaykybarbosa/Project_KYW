import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyw_management/utils/colors.dart';

abstract class TTextTheme {
  static const _lightColor = TColors.secondary;

  static TextTheme light = TextTheme(
    displayLarge: GoogleFonts.roboto().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: _lightColor),
    displayMedium: GoogleFonts.roboto()
        .copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: _lightColor.withOpacity(.5)),
    displaySmall: GoogleFonts.roboto()
        .copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: _lightColor.withOpacity(.5)),
    //
    headlineLarge: GoogleFonts.roboto().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: _lightColor),
    headlineMedium: GoogleFonts.roboto().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: _lightColor),
    headlineSmall: GoogleFonts.roboto().copyWith(fontSize: 22.0, fontWeight: FontWeight.w600, color: _lightColor),
    //
    titleLarge: GoogleFonts.roboto().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: _lightColor),
    titleMedium: GoogleFonts.roboto().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: _lightColor),
    titleSmall: GoogleFonts.roboto().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: _lightColor),
    //
    bodyLarge: GoogleFonts.roboto().copyWith(fontSize: 15.0, fontWeight: FontWeight.w500, color: _lightColor),
    bodyMedium: GoogleFonts.roboto().copyWith(fontSize: 15.0, fontWeight: FontWeight.normal, color: _lightColor),
    bodySmall:
        GoogleFonts.roboto().copyWith(fontSize: 15.0, fontWeight: FontWeight.w500, color: _lightColor.withOpacity(.5)),
    //
    labelLarge: GoogleFonts.roboto().copyWith(fontSize: 13.0, fontWeight: FontWeight.normal, color: _lightColor),
    labelMedium: GoogleFonts.roboto()
        .copyWith(fontSize: 13.0, fontWeight: FontWeight.normal, color: _lightColor.withOpacity(.5)),
    labelSmall: GoogleFonts.roboto()
        .copyWith(fontSize: 13.0, fontWeight: FontWeight.normal, color: _lightColor.withOpacity(.5)),
  );
}
