import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.image,
    this.onTap,
    this.firstRadius = 65,
    this.secoundRadius = 60,
    this.iconSize = 35.0,
    this.changeIconVisible = true,
  });

  final double firstRadius;
  final double secoundRadius;
  final File? image;
  final Function()? onTap;
  final double iconSize;
  final bool changeIconVisible;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: const Alignment(1.1, .6),
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
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        TIcons.userGroup,
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
