import 'package:flutter/material.dart';
import 'package:kyw_management/utils/constants.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(
          fontSize: TConstants.fontSizeLg + 2,
          fontWeight: FontWeight.w500,
        ),
      );
}
