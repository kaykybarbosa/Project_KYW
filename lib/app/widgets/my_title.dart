import 'package:flutter/cupertino.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(50, 58, 71, 1),
      ),
    );
  }
}
