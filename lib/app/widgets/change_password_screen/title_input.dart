import 'package:flutter/cupertino.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
