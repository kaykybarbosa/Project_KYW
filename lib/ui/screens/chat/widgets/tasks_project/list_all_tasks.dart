import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/ui/screens/chat/widgets/tasks_project/add_button_tasks.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_state.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';

class ListAllTaks extends StatelessWidget {
  const ListAllTaks({
    super.key,
    required String projectId,
  }) : _projectId = projectId;

  final String _projectId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        List<Task>? allTasks = context.select(
          (ProjectBloc bloc) => bloc.state.allProject.firstWhere((project) => project.id == _projectId).tasks,
        );
        return Expanded(
          child: Stack(
            children: [
              // List tasks
              if (allTasks != null)
                ListView(children: allTasks.map((task) => CardTask(task: task)).toList())
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
              AddButtonTasks(projectId: _projectId),
            ],
          ),
        );
      },
    );
  }
}
