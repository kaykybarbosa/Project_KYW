import 'package:flutter/material.dart';
import 'package:kyw_management/app/models/project.dart';

import '../../../../models/task.dart';
import '../../../../widgets/card_task.dart';
import 'add_button_tasks.dart';

class ListAllTaks extends StatefulWidget {
  const ListAllTaks({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  State<ListAllTaks> createState() => _ListAllTaksState();
}

class _ListAllTaksState extends State<ListAllTaks> {
  late final ScrollController _controller;

  void changedTasks() {}

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    _controller.addListener(() => changedTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          // List tasks
          if (widget.project.tasks != null)
            ListView.builder(
              controller: ScrollController(),
              itemCount: widget.project.tasks!.length,
              itemBuilder: (context, index) {
                List<Task> tasks = widget.project.tasks!;
                return CardTask(task: tasks[index]);
              },
            )
          else
            Center(
              child: Text(
                'Sem tarefas ainda!',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                ),
              ),
            ),
          // Add task button
          AddButtonTasks(projectId: widget.project.id),
        ],
      ),
    );
  }
}
