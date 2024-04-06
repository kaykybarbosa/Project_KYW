import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';

class ListTasks extends StatelessWidget {
  const ListTasks({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 7.5),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return CardTask(task: tasks[index]);
      },
    );
  }
}
