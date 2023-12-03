import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigOption extends StatelessWidget {
  const ConfigOption({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 17.0,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(color: CupertinoColors.systemGrey4),
      ),
      dense: true,
    );
  }
}
