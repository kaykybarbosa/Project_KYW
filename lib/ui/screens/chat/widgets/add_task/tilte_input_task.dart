import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../state_management/cubits/add_task_cubit/add_task_cubit.dart';
import '../../../../widgets/create_project_screen.dart/my_text_field.dart';

class TitleInputTask extends StatelessWidget {
  const TitleInputTask({super.key});

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
