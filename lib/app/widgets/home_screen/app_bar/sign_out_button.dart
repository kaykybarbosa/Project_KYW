import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(40, 255, 58, 48),
            borderRadius: BorderRadius.circular(5.0)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.rightFromBracket,
              color: CupertinoColors.systemRed,
              size: 23.0,
            ),
            SizedBox(width: 15.0),
            Text(
              'Sair',
              style: TextStyle(
                color: CupertinoColors.systemRed,
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
