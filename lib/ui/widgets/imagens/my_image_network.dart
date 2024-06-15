import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MyImageNetwork extends StatelessWidget {
  const MyImageNetwork({
    super.key,
    this.image,
    this.assetsReplace = '',
    this.width = TConstants.imageCircular,
    this.cacheWidth,
    this.cacheHeight,
    this.fit = BoxFit.cover,
  });

  final String? image;
  final String assetsReplace;
  final double width;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Container(
            width: width,
            decoration: BoxDecoration(
              color: TColors.base150,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  image!,
                  maxWidth: cacheWidth,
                  maxHeight: cacheHeight,
                ),
                fit: fit,
                onError: (obj, stack) => log('$obj'),
              ),
            ),
          )
        : Container(
            width: width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              assetsReplace,
              width: width,
              fit: BoxFit.contain,
            ),
          );
  }
}
