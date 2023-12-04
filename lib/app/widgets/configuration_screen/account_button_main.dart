import 'package:flutter/cupertino.dart';

class AccountButtonMain extends StatelessWidget {
  const AccountButtonMain(
      {super.key,
      required this.label,
      required this.onTap,
      this.isDanger = false});

  final String label;
  final Function onTap;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: isDanger ? CupertinoColors.systemRed : const Color(0xFF06AC93),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: CupertinoColors.white,
          ),
        ),
        onPressed: () {
          onTap();
        },
      ),
    );
  }
}
