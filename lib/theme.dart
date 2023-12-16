import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  primaryColor: const Color.fromRGBO(50, 58, 71, 1),
  colorScheme: const ColorScheme.light(
    primary: Color.fromRGBO(50, 58, 71, 1),
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
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Colors.grey),
    filled: true,
    border: const OutlineInputBorder(),
    enabledBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    fillColor: Colors.grey[200],
    focusedBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
  ),
  searchBarTheme: const SearchBarThemeData(),
  checkboxTheme: CheckboxThemeData(
    splashRadius: 16,
    checkColor: const MaterialStatePropertyAll(Colors.white),
    overlayColor: MaterialStatePropertyAll(Colors.grey[800]),
  ),
  datePickerTheme: DatePickerThemeData(
    headerBackgroundColor: const Color.fromRGBO(50, 58, 71, 1),
    headerForegroundColor: Colors.white,
    backgroundColor: Colors.grey[300],
  ),
);
