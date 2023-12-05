import 'package:flutter/material.dart';
import 'package:kyw_management/app/enums/filters_enum.dart';
import 'package:kyw_management/app/enums/screens.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/apply_button.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_buttons.dart';

class Order extends StatelessWidget {
  const Order({super.key, required this.currentScreen});

  final Screens currentScreen;

  @override
  Widget build(BuildContext context) {
    final List<String> optionsOrderProject = [
      'Mais antigos',
      'Mais novos',
      'Meus projetos',
      'Projetos marcados'
    ];
    final List<String> optionsOrderTask = [
      'Mais antigos',
      'Mais novos',
      'Minhas tarefas',
      'Tarefas marcadas'
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 33.0),
      child: Column(
        children: [
          // Options the Order
          Expanded(
            child: Column(
              children: [
                FilterButtons(
                  current: FilterEnum.Order,
                  resetFunction: () {},
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          currentScreen == Screens.project
                              ? optionsOrderProject[index]
                              : optionsOrderTask[index],
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        onTap: () {},
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    separatorBuilder: (__, _) => const Divider(height: 0.0),
                    itemCount: currentScreen == Screens.project
                        ? optionsOrderProject.length
                        : optionsOrderTask.length,
                  ),
                ),
              ],
            ),
          ),

          // Buttom apply Order
          ApplyButtom(onTap: () {})
        ],
      ),
    );
  }
}
