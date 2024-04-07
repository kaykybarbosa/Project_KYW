import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/widgets/apply_button.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_buttons.dart';
import 'package:kyw_management/utils/constants.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key, required this.currentScreen});

  final Screens currentScreen;

  @override
  Widget build(BuildContext context) {
    final List<String> optionsOrderProject = ['Mais antigos', 'Mais novos', 'Meus projetos', 'Projetos marcados'];
    final List<String> optionsOrderTask = ['Mais antigos', 'Mais novos', 'Minhas tarefas', 'Tarefas marcadas'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                /// Header
                FilterButtons(
                  current: FilterEnum.Order,
                  clearFunction: () {},
                ),

                /// Opções
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          currentScreen == Screens.project ? optionsOrderProject[index] : optionsOrderTask[index],
                          style: const TextStyle(fontSize: TConstants.fontSizeLg),
                        ),
                        onTap: () {},
                      );
                    },
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (__, _) => const Divider(height: 0),
                    itemCount: currentScreen == Screens.project ? optionsOrderProject.length : optionsOrderTask.length,
                  ),
                ),
              ],
            ),
          ),

          // Aplicar filtro
          ApplyButtom(onPressed: () {})
        ],
      ),
    );
  }
}
