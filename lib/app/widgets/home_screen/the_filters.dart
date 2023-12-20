import 'package:flutter/material.dart';

class TheFilters extends StatelessWidget {
  const TheFilters({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
    this.labelSize,
    this.iconSize,
  });

  final Function onTap;
  final String label;
  final double? labelSize;
  final IconData icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: labelSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5.0),
            Icon(
              icon,
              color: Colors.grey[400],
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
