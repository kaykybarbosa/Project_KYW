import 'package:flutter/material.dart';
import 'package:kyw_management/app/models/project.dart';

import '../../../../models/task.dart';
import '../../../../widgets/card_task.dart';
import 'add_button_tasks.dart';

class ListAllTaks extends StatelessWidget {
  const ListAllTaks({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          // List tasks
          project.tasks != null
              ? ListView.builder(
                  itemCount: project.tasks!.length,
                  itemBuilder: (context, index) {
                    List<Task> tasks = project.tasks!;
                    return CardTask(task: tasks[index]);
                  },
                )
              : Center(
                  child: Text(
                    'Sem tarefas ainda!',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20,
                    ),
                  ),
                ),
          // Add task button
          const AddButtonTasks(),
        ],
      ),
    );
  }
}
