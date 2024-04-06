import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/apply_button.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_buttons.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key, required this.currentScreen});

  final Screens currentScreen;

  @override
  Widget build(BuildContext context) {
    final List<String> optionsOrderProject = ['Mais antigos', 'Mais novos', 'Meus projetos', 'Projetos marcados'];
    final List<String> optionsOrderTask = ['Mais antigos', 'Mais novos', 'Minhas tarefas', 'Tarefas marcadas'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: Column(
        children: [
          // Options the Order
          Expanded(
            child: Column(
              children: [
                FilterButtons(
                  current: FilterEnum.Order,
                  clearFunction: () {},
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          currentScreen == Screens.project ? optionsOrderProject[index] : optionsOrderTask[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () {},
                      );
                    },
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (__, _) => const Divider(height: 0),
                    itemCount: currentScreen == Screens.project ? optionsOrderProject.length : optionsOrderTask.length,
                  ),
                ),
              ],
            ),
          ),

          // Buttom apply Order
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ApplyButtom(onPressed: () {}),
          )
        ],
      ),
    );
  }
}
