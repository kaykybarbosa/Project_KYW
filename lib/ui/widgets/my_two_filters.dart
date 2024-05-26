import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class MyTwoFilters extends StatelessWidget {
  const MyTwoFilters({
    super.key,
    required this.filterOnTap,
    required this.orderOnTap,
    this.padding,
  });

  final Function()? filterOnTap;
  final Function()? orderOnTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /// Filtrar
            MyFilter(
              onTap: filterOnTap,
              icon: TIcons.filter,
              label: TTexts.filter,
            ),

            /// Ordenar
            MyFilter(
              onTap: orderOnTap,
              iconSize: TConstants.iconMd,
              icon: TIcons.order,
              label: TTexts.order,
            ),
          ],
        ),
      );
}

class MyFilter extends StatelessWidget {
  const MyFilter({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
    this.labelSize = TConstants.fontSizeMd,
    this.iconSize = TConstants.iconSm,
  });

  final Function()? onTap;
  final String label;
  final double? labelSize;
  final IconData icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
              border: Border.all(color: TColors.base200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /// Nome
                Text(
                  label,
                  style: TextStyle(
                    fontSize: labelSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(5),

                /// Ícone
                Icon(
                  icon,
                  color: TColors.base200,
                  size: iconSize,
                ),
              ],
            ),
          ),
        ),
      );
}
