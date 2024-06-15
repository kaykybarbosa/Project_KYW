import 'package:flutter/material.dart';
import 'package:kyw_management/utils/constants.dart';

class MyExpansionTitle extends StatelessWidget {
  const MyExpansionTitle(
    this.title, {
    super.key,
    this.style = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  });

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: style?.copyWith(fontSize: TConstants.fontSizeMd),
      );
}
