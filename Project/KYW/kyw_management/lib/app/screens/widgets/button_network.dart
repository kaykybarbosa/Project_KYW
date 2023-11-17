import 'package:flutter/cupertino.dart';

class ButtonNetwork extends StatelessWidget {
  const ButtonNetwork(
      {super.key, required this.text, required this.image, this.width = 160});

  final String text;
  final Image image;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CupertinoColors.black, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            image,
            Text(
              text,
              style:
                  const TextStyle(fontSize: 20, color: CupertinoColors.black),
            )
          ],
        ),
      ),
    );
  }
}
