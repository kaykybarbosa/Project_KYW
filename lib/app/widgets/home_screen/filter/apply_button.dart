import 'package:flutter/cupertino.dart';

class ApplyButtom extends StatelessWidget {
  const ApplyButtom({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: CupertinoColors.systemBlue,
        child: const Text(
          'Aplicar',
          style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500),
        ),
        onPressed: () {
          onTap();
        },
      ),
    );
  }
}
