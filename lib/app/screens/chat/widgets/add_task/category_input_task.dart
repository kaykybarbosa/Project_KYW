import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/cubits/add_task_cubit/add_task_cubit.dart';
import '../../../../widgets/create_project_screen.dart/my_text_field.dart';

class CategoryInputTask extends StatelessWidget {
  const CategoryInputTask({super.key});

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
          onChange: (value) => context.read<AddTaskCubit>().categoryChanged(value),
          errorMessage: state.category.displayError,
        );
      },
    );
  }
}
