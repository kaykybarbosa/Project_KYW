import 'package:flutter/material.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/widgets/imagens/my_image_network.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class AvatarUrlTile extends StatelessWidget {
  const AvatarUrlTile({
    super.key,
    this.avatarUrl,
    this.width = TConstants.imageCircular,
    this.assetsReplace = 'assets/user.png',
    this.cacheWidth = 157,
    this.cacheHeight = 157,
  });

  final String? avatarUrl;
  final String assetsReplace;
  final double width;
  final int cacheWidth;
  final int cacheHeight;

  @override
  Widget build(BuildContext context) {
    return avatarUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Container(
              color: TColors.base150,
              child: Image.network(
                avatarUrl!,
                width: width,
                height: width,
                cacheWidth: cacheWidth,
                cacheHeight: cacheHeight,
                fit: BoxFit.cover,
              ),
            ),
          )
        : MyImageNetwork(
            width: width,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            assetsReplace: assetsReplace,
          );
  }
}
