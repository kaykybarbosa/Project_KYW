import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/ui/screens/chat/widgets/tasks_project/add_button_tasks.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';

class ListAllTaks extends StatelessWidget {
  const ListAllTaks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        List<Task>? allTasks = [];
        return Expanded(
          child: Stack(
            children: [
              // List tasks
              ListView(children: allTasks.map((task) => CardTask(task: task)).toList()),
              // Add task button
              const AddButtonTasks(),
            ],
          ),
        );
      },
    );
  }
}
