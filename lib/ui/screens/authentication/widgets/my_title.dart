import 'package:flutter/cupertino.dart';
import 'package:kyw_management/utils/colors.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: TColors.secondary,
          ),
        ),
      );
}
