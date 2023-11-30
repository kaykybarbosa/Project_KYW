import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(1.1, .6),
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              color: CupertinoColors.systemGrey2,
              borderRadius: BorderRadius.circular(60.0),
              boxShadow: const [
                BoxShadow(
                  color: CupertinoColors.systemGrey,
                  spreadRadius: .3,
                  blurRadius: 5.5,
                )
              ]),
          child: const Icon(
            FontAwesomeIcons.solidUser,
            size: 45.0,
            color: CupertinoColors.white,
          ),
        ),
        Stack(
          alignment: const Alignment(2.5, -2.5),
          children: [
            Container(
              width: 22.0,
              height: 22.0,
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(6.0)),
              child: const Text(''),
            ),
            GestureDetector(
              onTap: () => onTap(),
              child: const Icon(
                FontAwesomeIcons.pen,
                size: 18.0,
                color: CupertinoColors.systemBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
