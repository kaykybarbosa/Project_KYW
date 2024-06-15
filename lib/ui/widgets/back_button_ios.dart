import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class BackButtonIOS extends StatelessWidget {
  const BackButtonIOS({
    super.key,
    this.positionedLeft,
    this.positionedTop,
    this.positionedRight,
    this.positionedBottom,
    this.color,
    this.iconSize,
    this.onPressed,
  });

  final double? positionedLeft;
  final double? positionedTop;
  final double? positionedRight;
  final double? positionedBottom;

  final Color? color;
  final double? iconSize;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => Positioned(
        left: positionedLeft ?? 10,
        top: positionedTop ?? 35,
        right: positionedRight,
        bottom: positionedBottom,
        child: IconButton(
          onPressed: onPressed ?? () => Get.back(),
          icon: Icon(
            TIcons.arrowLeftIOS,
            color: color ?? TColors.base150,
            size: iconSize,
          ),
        ),
      );
}
