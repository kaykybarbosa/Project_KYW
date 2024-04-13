import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/widgets/apply_button.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_buttons.dart';
import 'package:kyw_management/ui/widgets/my_draggable_scroll.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key, required this.currentScreen});

  final Screens currentScreen;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> optionsOrderProject = [
      {
        'title': 'Mais antigos',
        'onTap': () {},
      },
      {
        'title': 'Mais novos',
        'onTap': () {},
      },
      {
        'title': 'Meus projetos',
        'onTap': () {},
      },
      {
        'title': 'Projetos marcados',
        'onTap': () {},
      },
    ];

    final List<Map<String, dynamic>> optionsOrderTask = [
      {
        'title': 'Mais antigos',
        'onTap': () {},
      },
      {
        'title': 'Mais novos',
        'onTap': () {},
      },
      {
        'title': 'Minhas tarefas',
        'onTap': () {},
      },
      {
        'title': 'Tarefas marcadas',
        'onTap': () {},
      },
    ];

    return Column(
      children: <Widget>[
        Expanded(
          child: MyDraggableScroll(
            padding: EdgeInsets.zero,

            /// Header
            header: Padding(
              padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
              child: FilterButtons(
                current: FilterEnum.Order,
                clearFunction: () {},
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: List.generate(
                  currentScreen == Screens.project ? optionsOrderProject.length : optionsOrderTask.length,
                  (index) {
                    var options = currentScreen == Screens.project ? optionsOrderProject : optionsOrderTask;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /// Primeiro divider
                        index == 0
                            ? const Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Divider(),
                              )
                            : Container(),

                        /// -- Opção
                        ListTile(
                          title: Text(
                            options[index]['title'],
                            style: const TextStyle(fontSize: TConstants.fontSizeLg),
                          ),
                          onTap: options[index]['onTap'],
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // Aplicar filtro
        ApplyButtom(
          color: TColors.base100,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          onPressed: () {},
        ),
      ],
    );
  }
}
