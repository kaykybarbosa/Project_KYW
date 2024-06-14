import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.image,
    this.imageUrl,
    this.onTap,
    this.icon = TIcons.userGroup,
    this.firstRadius = 65,
    this.secoundRadius = 60,
    this.iconSize = 35.0,
    this.changeIconVisible = true,
    this.containerSize = 22,
    this.iconContainerSize = TConstants.iconSm + 2,
    this.iconWithPadding = true,
    this.align = 1.0,
  });

  const CircleImage.medium({
    super.key,
    this.image,
    this.imageUrl,
    this.onTap,
    this.icon = TIcons.userGroup,
    this.firstRadius = 55,
    this.secoundRadius = 130,
    this.iconSize = 30.0,
    this.changeIconVisible = true,
    this.containerSize = 18,
    this.iconContainerSize = TConstants.iconXs + 2,
    this.iconWithPadding = true,
    this.align = .95,
  });

  final double firstRadius;
  final double secoundRadius;
  final File? image;
  final String? imageUrl;
  final double iconSize;
  final IconData icon;
  final bool changeIconVisible;
  final bool iconWithPadding;
  final double containerSize;
  final double iconContainerSize;
  final double align;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment(align, .6),
        children: <Widget>[
          /// Imagem
          CircleAvatar(
            radius: firstRadius,
            backgroundColor: TColors.base200.withOpacity(.2),
            child: CircleAvatar(
              radius: secoundRadius,
              backgroundColor: TColors.base200,
              backgroundImage: image != null ? FileImage(image!) : null,
              child: image == null
                  ? Padding(
                      padding: EdgeInsets.only(right: iconWithPadding ? 5 : 0),
                      child: Icon(
                        icon,
                        size: iconSize,
                        color: TColors.base100,
                      ),
                    )
                  : null,
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
                    width: containerSize,
                    height: containerSize,
                    padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                    decoration: BoxDecoration(
                      color: TColors.base100,
                      border: Border.all(color: TColors.base200),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(),
                  ),
                  Icon(
                    TIcons.pen,
                    size: iconContainerSize,
                    color: TColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
