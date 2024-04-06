import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';

import '../../../../../domain/models/task.dart';
import '../../../../state_management/cubits/add_task_cubit/add_task_cubit.dart';

class SubmitButtonTask extends StatelessWidget {
  const SubmitButtonTask({super.key, required String projectId}) : _projectId = projectId;

  final String _projectId;

  @override
  Widget build(BuildContext context) {
    void addTask(AddTaskState state) {
      Task task = Task(
        title: state.title.value,
        dateOfConclusion: DateTime.tryParse(state.dateOfConclusion),
        description: state.description.value,
      );
      context.read<ProjectBloc>().add(AddTaskProject(
            projectId: _projectId,
            task: task,
          ));
    }

    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: BlocListener<AddTaskCubit, AddTaskState>(
              listener: (context, state) {
                if (state.status.isSuccess) {
                  addTask(state);

                  Get.back();
                  Get.snackbar(
                    'Sucesso!',
                    'Tarefa adicionada!',
                    backgroundColor: Theme.of(context).primaryColor,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    dismissDirection: DismissDirection.horizontal,
                  );
                }
              },
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(state.isValid ? Colors.white : Colors.white70),
                  backgroundColor: MaterialStatePropertyAll(
                      state.isValid ? const Color.fromARGB(255, 6, 172, 147) : const Color.fromARGB(240, 6, 172, 147)),
                ),
                onPressed: state.isValid ? () => context.read<AddTaskCubit>().formAddTaskSubmitted() : null,
                child: state.status.isInProgress
                    ? Transform.scale(
                        scale: 0.44,
                        child: const CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        'Criar tarefa',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
