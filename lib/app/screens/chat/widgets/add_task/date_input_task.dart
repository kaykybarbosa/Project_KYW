import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/cubits/add_task_cubit/add_task_cubit.dart';
import '../../../../widgets/create_project_screen.dart/my_text_field.dart';

class DateInputTask extends StatelessWidget {
  const DateInputTask({super.key, required TextEditingController controller}) : _controller = controller;

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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: BlocListener<AddTaskCubit, AddTaskState>(
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
      ),
    );
  }
}