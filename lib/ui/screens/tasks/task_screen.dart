import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_sliver_list.dart';
import 'package:kyw_management/ui/screens/tasks/widgets/my_modal_filter_task.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/my_order.dart';
import 'package:kyw_management/ui/widgets/my_search_bar.dart';
import 'package:kyw_management/ui/widgets/my_two_filters.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  Future<dynamic> myModalBottom(BuildContext context, Widget child) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var tasks = [
      Task(
        isImportant: true,
        title: 'Concluir o Projeto Integrador',
        dateOfConclusion: DateTime(2024, 06, 25),
        status: TaskStatus.pending,
      ),
      Task(
        title: 'Concluir o Projeto Integrador',
        description: 'Lorem sdjks jdsidj skdi ',
        dateOfConclusion: DateTime(2024, 06, 25),
        status: TaskStatus.complete,
      ),
    ];

    return Scaffold(
      body: Column(
        children: <Widget>[
          /// Buscar tarefas
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TConstants.defaultMargin,
              vertical: 10,
            ),
            child: MySearchBar(
              hintText: TTexts.hintTextTask,
              onPressed: () {},
            ),
          ),

          /// Filtros
          MyTwoFilters(
            /// -- Filtrar
            filterOnTap: () => myModalBottom(context, const MyModalFilterTask()),

            /// -- Ordenar
            orderOnTap: () => myModalBottom(
              context,
              const MyOrder(currentScreen: Screens.task),
            ),
          ),

          /// Lista de tarefas
          Expanded(
            child: MySliverList(
              childCount: tasks.length,
              builder: (_, index) => Padding(
                padding: EdgeInsets.only(bottom: index != tasks.length - 1 ? 10 : 0),
                child: CardTask(task: tasks[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
