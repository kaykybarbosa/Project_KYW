import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../domain/cubits/add_task_cubit/add_task_cubit.dart';

class SubmitButtonTask extends StatelessWidget {
  const SubmitButtonTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(state.isValid ? Colors.white : Colors.white70),
              backgroundColor: MaterialStatePropertyAll(
                  state.isValid ? const Color.fromARGB(255, 6, 172, 147) : const Color.fromARGB(240, 6, 172, 147)),
            ),
            onPressed: state.isValid ? () {} : null,
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
        );
      },
    );
  }
}
