import 'package:flutter/cupertino.dart';

class MyDecorations {
  static Color primaryColor = const Color.fromRGBO(50, 58, 71, 1);
  static Color backGroundColor = CupertinoColors.systemGrey6;
  static Color myInputColor = CupertinoColors.systemGrey5;
  static Color myBorderColor = CupertinoColors.inactiveGray;

  static BoxDecoration inputDecoration(
      {Color? borderColor, Color? inputColor, bool isActice = false}) {
    return BoxDecoration(
      color: isActice ? (inputColor ?? myInputColor) : null,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        width: 1,
        color: borderColor ?? myBorderColor,
      ),
    );
  }

  static TextStyle placeHolderStyle(
      {Color? placeHolderColor, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize ?? 20,
      color: placeHolderColor ?? CupertinoColors.placeholderText,
      fontWeight: FontWeight.w500,
      height: 2.0,
    );
  }

  static TextStyle textSpanStyle() {
    return const TextStyle(
      color: CupertinoColors.black,
      fontSize: 18,
    );
  }

  static TextStyle inputTextStyle() {
    return TextStyle(
      color: primaryColor,
      fontSize: 21,
    );
  }
}
