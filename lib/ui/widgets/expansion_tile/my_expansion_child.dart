import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MyExpansionChild extends StatelessWidget {
  const MyExpansionChild({
    super.key,
    required this.child,
    this.isFirst = true,
    this.isLast = true,
  });

  final bool isFirst;
  final bool isLast;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: TColors.base100,
          borderRadius: BorderRadius.vertical(
            bottom: isLast ? const Radius.circular(TConstants.cardRadiusXs) : Radius.zero,
          ),
          border: Border(
            top: isFirst ? const BorderSide(color: TColors.base200) : BorderSide.none,
            bottom: isLast ? BorderSide.none : const BorderSide(color: TColors.base200),
          ),
        ),
        child: child,
      );
}
