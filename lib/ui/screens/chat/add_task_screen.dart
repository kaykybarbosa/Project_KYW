import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kyw_management/ui/state_management/cubits/add_task_cubit/add_task_cubit.dart';

import 'widgets/add_task/category_input_task.dart';
import 'widgets/add_task/date_input_task.dart';
import 'widgets/add_task/description_input_task.dart';
import 'widgets/add_task/selected_members_task.dart';
import 'widgets/add_task/submited_button_task.dart';
import 'widgets/add_task/tilte_input_task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required String projectId}) : _projectId = projectId;

  final String _projectId;
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),

        /// TODO: Remover registro do cubit
        child: BlocProvider(
          create: (context) => AddTaskCubit(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Title(),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: BlocBuilder<AddTaskCubit, AddTaskState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              const TitleInputTask(),
                              CategoryInputTask(),
                              DateInputTask(controller: _dateController),
                              const SelectMembersTask(),
                              const SizedBox(height: 20),
                              const DescriptionInputTask(),
                              const SizedBox(height: 40),
                              SubmitButtonTask(projectId: widget._projectId),
                              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 29,
          ),
          onPressed: () => Get.back(),
        ),
        const SizedBox(width: 8),
        Text(
          'Criar Tarefa',
          style: TextStyle(
            color: Colors.blue[700],
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
