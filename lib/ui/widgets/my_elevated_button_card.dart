import 'package:flutter/material.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/utils/colors.dart';

class MyElevatedButtonCard extends StatelessWidget {
  const MyElevatedButtonCard({
    super.key,
    required this.child,
    this.isDanger = false,
    this.isRight = false,
    this.isAlone = false,
    this.backgroundColor,
    this.foregroundColor,
    this.disableBackgroundColor,
    this.shadowColor = Colors.transparent,
    this.elevation,
    this.padding,
    required this.onPressed,
  });

  final Widget child;
  final bool isDanger;
  final bool isRight;
  final bool isAlone;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disableBackgroundColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final Color shadowColor;
  final void Function()? onPressed;

  double get _borderRadius => TConstants.cardRadiusSm;
  Color get _disabledBackgroundColor => TColors.base100.withOpacity(.9);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: isRight || isAlone
          ? null
          : BoxDecoration(
              border: Border(right: BorderSide(color: Theme.of(context).dividerTheme.color!)),
            ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          shadowColor: shadowColor,
          foregroundColor: foregroundColor ?? (isDanger ? colorScheme.error : colorScheme.primary),
          backgroundColor: backgroundColor ?? colorScheme.onPrimaryContainer,
          disabledBackgroundColor: isDanger ? _disabledBackgroundColor.withOpacity(.10) : disableBackgroundColor,
          disabledForegroundColor: isDanger ? colorScheme.error.withOpacity(.44) : null,
          shape: isAlone
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                  ),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: isRight ? Radius.zero : Radius.circular(_borderRadius),
                    bottomRight: isRight ? Radius.circular(_borderRadius) : Radius.zero,
                  ),
                ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
