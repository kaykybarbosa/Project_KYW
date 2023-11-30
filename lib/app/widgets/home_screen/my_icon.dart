import 'package:flutter/cupertino.dart';

class MyIcon extends StatelessWidget {
  const MyIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Icon(
        icon,
        color: color,
        size: 22.0,
      ),
    );
  }
}
