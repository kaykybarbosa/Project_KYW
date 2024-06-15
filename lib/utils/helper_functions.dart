import 'package:flutter/material.dart';

class HelperFunctions {
  static TextStyle hintStyle(context) => Theme.of(context).inputDecorationTheme.hintStyle!;

  static BorderSide border(context) => Theme.of(context).inputDecorationTheme.border!.borderSide;

  static BorderSide focusedBorder(context) => Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide;

  static BorderSide enabledBorder(context) => BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(.5));

  static BorderSide errorBorder(context) => Theme.of(context).inputDecorationTheme.errorBorder!.borderSide;

  static BorderSide focusedErrorBorder(context) =>
      Theme.of(context).inputDecorationTheme.focusedErrorBorder!.borderSide;
}
