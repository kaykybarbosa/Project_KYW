import 'package:flutter/cupertino.dart';

class ContinueWith extends StatelessWidget {
  const ContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.0,
            color: CupertinoColors.separator,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Text(
            'Ou continue com',
            style: TextStyle(color: CupertinoColors.systemGrey),
          ),
        ),
        Expanded(
          child: Container(
            height: 1.0,
            color: CupertinoColors.separator,
          ),
        ),
      ],
    );
  }
}
