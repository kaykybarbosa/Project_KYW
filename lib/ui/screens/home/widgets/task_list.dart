import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_sliver_list.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/my_modal_filter_task.dart';
import 'package:kyw_management/ui/widgets/my_search_bar.dart';
import 'package:kyw_management/ui/widgets/my_two_filters.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  Future<dynamic> myModalBottom({required BuildContext context}) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: TColors.base100,
      builder: (BuildContext context) => const SizedBox(
        height: 665,
        child: MyModalFilterTask(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tasks = [
      Task(
        title: 'Concluir o Projeto Integrador',
        dateOfConclusion: DateTime(2024, 06, 25),
        status: TaskStatus.pending,
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
            filterOnTap: () => myModalBottom(context: context),
            orderOnTap: () {},
          ),

          /// Lista de tarefas
          Expanded(
            child: MySliverList(
              childCount: tasks.length,
              builder: (_, index) => CardTask(task: tasks[index]),
            ),
          ),
        ],
      ),
    );
  }
}
