import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
    required this.current,
    required this.clearFunction,
  });

  final FilterEnum current;
  final Function() clearFunction;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _Button(
            onTap: () => Get.back(),
            label: TTexts.cancel,
          ),
          _Button(
            label: current.isFilter ? '${TTexts.filter} ' : '${TTexts.order} ',
            color: TColors.secondary,
          ),
          _Button(
            onTap: clearFunction,
            label: TTexts.clean,
          ),
        ],
      );
}

class _Button extends StatelessWidget {
  const _Button({
    this.onTap,
    this.color,
    required this.label,
  });

  final String label;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Text(
          label,
          style: TextStyle(
            fontSize: TConstants.fontSizeLg + 2,
            color: color ?? TColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
