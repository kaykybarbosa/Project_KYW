import 'package:flutter/material.dart';
import 'package:kyw_management/ui/widgets/imagens/my_image_network.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class AvatarUrlTile extends StatelessWidget {
  const AvatarUrlTile({
    super.key,
    this.avatarUrl,
    this.assetsReplace = 'assets/user.png',
    this.cacheWidth = 157,
    this.cacheHeight = 157,
  });

  final String? avatarUrl;
  final String assetsReplace;
  final int cacheWidth;
  final int cacheHeight;

  @override
  Widget build(BuildContext context) {
    return avatarUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: TColors.base150,
              child: Image.network(
                avatarUrl!,
                width: TConstants.imageCircular,
                height: TConstants.imageCircular,
                cacheWidth: cacheWidth,
                cacheHeight: cacheHeight,
                fit: BoxFit.cover,
              ),
            ),
          )
        : MyImageNetwork(
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            assetsReplace: assetsReplace,
          );
  }
}
