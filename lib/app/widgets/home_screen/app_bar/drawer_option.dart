import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(
        icon,
        color: CupertinoColors.systemBlue,
        size: 23.0,
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }
}
