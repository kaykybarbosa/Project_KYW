import 'package:flutter/cupertino.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => onTap(),
          child: const Text(
            'Esqueceu a senha ?',
            textAlign: TextAlign.start,
            style: TextStyle(color: CupertinoColors.link),
          ),
        ),
      ],
    );
  }
}
