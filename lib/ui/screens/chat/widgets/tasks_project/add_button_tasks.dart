import 'package:flutter/material.dart';

import '../../add_task_screen.dart';

class AddButtonTasks extends StatelessWidget {
  const AddButtonTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height - 35,
                child: const AddTaskScreen(),
              ),
            ),
            backgroundColor: Colors.blue[700],
            child: const Icon(
              Icons.add,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
