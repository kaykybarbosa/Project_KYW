import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.onTap,
    this.iconSize = 45.0,
    this.changeIconVisible = true,
    this.padding = const EdgeInsets.all(38.0),
  });

  final Function()? onTap;
  final double iconSize;
  final bool changeIconVisible;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: const Alignment(1.1, .6),
        children: <Widget>[
          /// Circulo
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: TColors.base200,
              borderRadius: BorderRadius.circular(60.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: TColors.base900.withOpacity(.33),
                  blurRadius: 10,
                ),
              ],
            ),

            /// Ícone
            child: Icon(
              TIcons.user,
              size: iconSize,
              color: TColors.base100,
            ),
          ),

          /// Ícone de alterar
          Visibility(
            visible: changeIconVisible,
            child: InkWell(
              onTap: onTap,
              child: Stack(
                alignment: const Alignment(2.5, -2.5),
                children: <Widget>[
                  Container(
                    width: 22.0,
                    height: 22.0,
                    padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                    decoration: BoxDecoration(
                      color: TColors.base100,
                      border: Border.all(color: TColors.base200),
                      borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
                    ),
                    child: Container(),
                  ),
                  const Icon(
                    TIcons.pen,
                    size: TConstants.iconSm + 2,
                    color: TColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
