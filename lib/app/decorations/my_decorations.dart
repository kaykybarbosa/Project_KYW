import 'package:flutter/cupertino.dart';

class MyDecorations {
  static Color primaryColor = const Color.fromRGBO(50, 58, 71, 1);
  static Color backGroundColor = CupertinoColors.systemGrey6;

  static BoxDecoration inputDecoration(
      {Color color = CupertinoColors.inactiveGray, bool valid = true}) {
    return BoxDecoration(
      border: Border.all(width: 1, color: color),
      borderRadius: BorderRadius.circular(6),
    );
  }

  static TextStyle placeHolderStyle() {
    return const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(60, 60, 67, 0.298),
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
