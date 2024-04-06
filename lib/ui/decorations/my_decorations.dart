import 'package:flutter/cupertino.dart';

class MyDecorations {
  static Color primaryColor = const Color.fromRGBO(50, 58, 71, 1);
  static Color backGroundColor = CupertinoColors.systemGrey6;
  static Color myInputColor = CupertinoColors.systemGrey5;
  static Color myBorderColor = CupertinoColors.inactiveGray;

  static BoxDecoration inputDecoration(
      {Color? borderColor,
      Color? inputColor,
      double? borderRadius,
      bool isActice = false}) {
    return BoxDecoration(
      color: isActice ? (inputColor ?? myInputColor) : null,
      borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
      border: Border.all(
        width: 1.0,
        color: borderColor ?? myBorderColor,
      ),
    );
  }

  static TextStyle placeHolderStyle(
      {Color? placeHolderColor, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize ?? 20.0,
      color: placeHolderColor ?? CupertinoColors.placeholderText,
      fontWeight: FontWeight.w500,
      height: 2.0,
    );
  }

  static TextStyle textSpanStyle() {
    return const TextStyle(
      color: CupertinoColors.black,
      fontSize: 18.0,
    );
  }

  static TextStyle inputTextStyle({double? fontSize}) {
    return TextStyle(
      color: primaryColor,
      fontSize: fontSize ?? 21.0,
    );
  }
}
