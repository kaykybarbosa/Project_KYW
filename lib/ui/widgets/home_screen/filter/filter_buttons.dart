import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key, required this.current, required this.clearFunction});

  final FilterEnum current;
  final Function clearFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _button(
          onTap: () => Navigator.pop(context),
          text: 'Cancelar',
          color: Colors.blue[600],
        ),
        _button(
          onTap: () {},
          text: current == FilterEnum.Filter ? 'Filtrar  ' : 'Ordenar  ',
          color: Colors.black,
        ),
        _button(
          onTap: () => clearFunction(),
          text: 'Limpar',
          color: Colors.blue[600],
        ),
      ],
    );
  }

  GestureDetector _button({
    required Function onTap,
    required String text,
    Color? color,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
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
