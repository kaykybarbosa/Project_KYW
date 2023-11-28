import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/widgets/card_task.dart';

class ListTasks extends StatelessWidget {
  const ListTasks({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return CardTask(task: tasks[index]);
      },
    );
  }
}
