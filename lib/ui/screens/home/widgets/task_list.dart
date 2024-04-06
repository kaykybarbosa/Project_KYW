import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_sliver_list.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';

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

    return MySliverList(
      childCount: tasks.length,
      builder: (_, index) => CardTask(task: tasks[index]),
    );
  }
}
