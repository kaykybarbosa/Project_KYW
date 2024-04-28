import 'package:flutter/material.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class ConfigOption extends StatelessWidget {
  const ConfigOption({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: TConstants.fontSizeLg,
          ),
        ),
        subtitle: Text(
          subTitle,
          style: const TextStyle(
            color: TColors.base200,
            fontSize: TConstants.fontSizeSm,
          ),
        ),
        dense: true,
      );
}
