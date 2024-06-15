import 'package:flutter/material.dart';
import 'package:kyw_management/utils/texts.dart';

class ApplyButtom extends StatelessWidget {
  const ApplyButtom({
    super.key,
    required this.onPressed,
    this.label = TTexts.apply,
    this.padding,
    this.color,
  });

  final String label;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        width: double.infinity,
        padding: padding ?? const EdgeInsets.only(bottom: 15),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      );
}
