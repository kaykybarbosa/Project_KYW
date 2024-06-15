import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';

class CircularProgressIndicatorMini extends StatelessWidget {
  const CircularProgressIndicatorMini({super.key});

  @override
  Widget build(BuildContext context) => Transform.scale(
        scale: 0.4,
        child: const CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(TColors.base100),
        ),
      );
}
