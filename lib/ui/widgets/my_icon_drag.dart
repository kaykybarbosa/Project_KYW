import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class MyIconDrag extends StatelessWidget {
  const MyIconDrag({
    super.key,
    this.isDrag = false,
    required this.onVerticalDragUpdate,
  });

  final bool isDrag;
  final void Function(double?) onVerticalDragUpdate;

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 25.0),
          decoration: const BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(TConstants.cardRadiusXs),
              bottomRight: Radius.circular(TConstants.cardRadiusXs),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedRotation(
                turns: isDrag ? -0.5 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  TIcons.anglesDown,
                  size: TConstants.iconSm,
                ),
              ),
            ],
          ),
        ),
        onVerticalDragUpdate: (onLong) => onVerticalDragUpdate(onLong.primaryDelta),
      );
}
