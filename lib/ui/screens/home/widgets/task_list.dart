import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_sliver_list.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';
import 'package:kyw_management/ui/widgets/my_search_bar.dart';
import 'package:kyw_management/ui/widgets/my_two_filters.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    var tasks = [
      Task(
        title: 'Concluir o Projeto Integrador',
        dateOfConclusion: DateTime(2024, 06, 25),
        status: TaskStatus.pending,
      ),
    ];

    return Column(
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
          filterOnTap: () {},
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
    );
  }
}
