import 'package:flutter/cupertino.dart';

class AppName extends StatelessWidget {
  const AppName({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(1, 0.3),
      child: Text(
        'KYW',
        style: TextStyle(
          color: color,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
