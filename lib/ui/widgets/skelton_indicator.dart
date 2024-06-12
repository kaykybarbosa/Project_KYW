import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class SkeltonIndicator extends StatelessWidget {
  const SkeltonIndicator({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(TConstants.cardRadiusSm),
        ),
      )
          .animate(
        onComplete: (controller) => controller.repeat(),
      )
          .shimmer(
        duration: 1500.milliseconds,
        colors: [
          baseColor,
          baseColor,
          highlightColor,
          baseColor,
          baseColor,
        ],
      );
}

Color get baseColor => TColors.base150.withOpacity(.2);
Color get highlightColor => Colors.grey[300]!;
