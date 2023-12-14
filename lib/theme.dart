import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  primaryColor: const Color.fromRGBO(50, 58, 71, 1),
  colorScheme: const ColorScheme.light(
    onPrimary: Color.fromRGBO(229, 229, 234, 1),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(50, 58, 71, 1),
    elevation: 0,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey[200],
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
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
  searchBarTheme: const SearchBarThemeData(),
);
