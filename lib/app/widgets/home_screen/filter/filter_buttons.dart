import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/enums/filters_enum.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key, required this.current, required this.reset});

  final FilterEnum current;
  final Function reset;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _button(
          onTap: () {
            Navigator.pop(context);
          },
          text: 'Cancelar',
          color: CupertinoColors.systemBlue,
        ),
        _button(
          onTap: () {},
          text: current.name,
          color: CupertinoColors.black,
        ),
        _button(
          onTap: () {
            reset();
          },
          text: 'Resetar',
          color: CupertinoColors.systemBlue,
        ),
      ],
    );
  }

  GestureDetector _button({
    required Function onTap,
    required String text,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
