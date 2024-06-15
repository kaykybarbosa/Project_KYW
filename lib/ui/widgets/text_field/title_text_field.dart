import 'package:flutter/material.dart';
import 'package:kyw_management/utils/constants.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField(this.text, {super.key, this.padding});

  final String? text;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding ?? const EdgeInsets.only(left: 2, bottom: 4),
        child: Text(
          text ?? '',
          style: TextStyle(
            fontSize: TConstants.fontSizeLg - 1,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
}
