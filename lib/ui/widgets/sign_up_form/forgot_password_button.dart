import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: const Text(
            'Esqueceu a senha ?',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
