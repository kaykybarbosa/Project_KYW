import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MyElevatedButtonUnderline extends StatelessWidget {
  const MyElevatedButtonUnderline({
    super.key,
    required this.onPressed,
    required this.label,
    this.borderRadius,
    this.style,
    this.padding,
  });

  final VoidCallback onPressed;
  final String label;
  final TextStyle? style;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: Colors.transparent,
          foregroundColor: TColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? TConstants.cardRadiusXs),
            side: const BorderSide(color: TColors.secondary),
          ),
        ),
        child: Text(
          label,
          style: style,
        ),
      );
}
