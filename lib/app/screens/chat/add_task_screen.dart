import 'package:flutter/material.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/my_text_field.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:kyw_management/domain/services/routers/export_routes.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: BlocProvider(
          create: (context) => AddTaskCubit(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Title(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: BlocBuilder<AddTaskCubit, AddTaskState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          const _TitleInput(),
                          const _CategoryInput(),
                          _DateInput(controller: _dateController),
                          Container(
                            color: Colors.blue[700],
                            child: const ListTile(
                              title: Text(
                                'Selecione os membros',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  const _TitleInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return MyTextField(
          text: 'Título*',
          placeHolder: 'Título',
          onChange: (value) => context.read<AddTaskCubit>().titleChanged(value),
          errorMessage: state.title.displayError != null ? 'Título é obrigatório!' : null,
        );
      },
    );
  }
}

class _CategoryInput extends StatelessWidget {
  const _CategoryInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        return MyTextField(
          text: 'Categoria*',
          placeHolder: 'Selecione a categoria',
          suffix: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_downward,
              color: Colors.blue[700],
            ),
          ),
          onChange: (value) {},
        );
      },
    );
  }
}

class _DateInput extends StatelessWidget {
  const _DateInput({required TextEditingController controller}) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    dateChaged(DateTime? date) {
      context.read<AddTaskCubit>().dateOfConclusionChanged(date);
    }

    selectingDate() async {
      var now = DateTime.now();

      DateTime? dateSelected = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 2),
      );

      dateChaged(dateSelected);
    }

    return BlocListener<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state.dateOfConclusion.isNotEmpty) {
          _controller.text = state.dateOfConclusion;
        }
      },
      child: GestureDetector(
        onTap: () => selectingDate(),
        child: MyTextField(
          controller: _controller,
          text: 'Data de conclusão*',
          placeHolder: 'dd/MM/yyyy',
          enable: false,
          suffix: const Icon(
            Icons.calendar_today_rounded,
            color: Colors.grey,
          ),
          onChange: (value) {},
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
