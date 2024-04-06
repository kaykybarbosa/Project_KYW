import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../widgets/home_screen/the_filters.dart';

class FiltersBarTasks extends StatelessWidget {
  const FiltersBarTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TheFilters(
          onTap: () {},
          label: 'Filtrar',
          labelSize: 17,
          iconSize: 17,
          icon: FontAwesomeIcons.filter,
        ),
        Chip(
          label: const Text('Mostrar todos'),
          labelStyle: TextStyle(color: Colors.blue[700]),
          labelPadding: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        TheFilters(
          onTap: () {},
          label: 'Ordenar',
          labelSize: 17,
          iconSize: 25,
          icon: FontAwesomeIcons.caretDown,
        ),
      ],
    );
  }
}
