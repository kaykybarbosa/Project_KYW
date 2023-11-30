import 'package:flutter/cupertino.dart';

class InputOfTitle extends StatelessWidget {
  const InputOfTitle({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
}
