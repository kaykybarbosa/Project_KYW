import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: const Color.fromRGBO(50, 58, 71, 1),
  scaffoldBackgroundColor: Colors.grey[200],
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      surfaceTintColor: MaterialStatePropertyAll(Colors.amber),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(50, 58, 71, 1)),
      overlayColor: MaterialStatePropertyAll(Colors.grey),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)))),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
  ),
);
