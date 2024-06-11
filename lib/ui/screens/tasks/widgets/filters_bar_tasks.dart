import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/widgets/my_two_filters.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class FiltersBarTasks extends StatelessWidget {
  const FiltersBarTasks({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MyFilter(
            onTap: () {},
            label: 'Filtrar',
            icon: TIcons.filter,
          ),
          GestureDetector(
            onTap: () {},
            child: const Chip(
              color: WidgetStatePropertyAll(TColors.clipBackground),
              label: Text('Mostrar todos'),
              labelStyle: TextStyle(color: TColors.primary),
              labelPadding: EdgeInsets.symmetric(horizontal: 2),
              padding: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: TColors.base200),
                borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
              ),
            ),
          ),
          MyFilter(
            onTap: () {},
            label: 'Ordenar',
            iconSize: TConstants.iconMd,
            icon: FontAwesomeIcons.caretDown,
          ),
        ],
      );
}
