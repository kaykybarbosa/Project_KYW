import 'package:flutter/material.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:kyw_management/domain/services/routers/export_routes.dart';

import 'widgets/add_task/category_input_task.dart';
import 'widgets/add_task/date_input_task.dart';
import 'widgets/add_task/description_input_task.dart';
import 'widgets/add_task/selected_members_task.dart';
import 'widgets/add_task/submited_button_task.dart';
import 'widgets/add_task/tilte_input_task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              const CategoryInputTask(),
                              DateInputTask(controller: _dateController),
                              const SelectMembersTask(),
                              const SizedBox(height: 20),
                              DescriptionInputTask(controller: _descriptionController),
                              const SizedBox(height: 40),
                              const SubmitButtonTask(),
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
          onPressed: () => context.pop(context),
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
