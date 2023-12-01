import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_task/filter_by_status.dart';

class FilterForTask extends StatefulWidget {
  const FilterForTask({super.key});

  @override
  State<FilterForTask> createState() => _FilterForTaskState();
}

class _FilterForTaskState extends State<FilterForTask> {
  bool _complete = false;
  bool _pending = false;
  bool _incomplete = false;

  void _setStatusTask({required Status status, bool? value}) {
    setState(() {
      if (value != null) {
        if (status == Status.complete) {
          _complete = value;
        } else if (status == Status.incomplete) {
          _incomplete = value;
        } else {
          _pending = value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The three Status CheckBox
        const Text(
          'Status',
          style: TextStyle(fontSize: 20.0),
        ),
        FilterByStatus(
          isChecked: _pending,
          status: Status.pending,
          onChanged: (value) {
            _setStatusTask(
              status: Status.pending,
              value: value,
            );
          },
        ),
        FilterByStatus(
          isChecked: _complete,
          status: Status.complete,
          onChanged: (value) {
            _setStatusTask(
              status: Status.complete,
              value: value,
            );
          },
        ),
        FilterByStatus(
          isChecked: _incomplete,
          status: Status.incomplete,
          onChanged: (value) {
            _setStatusTask(
              status: Status.incomplete,
              value: value,
            );
          },
        ),

        const SizedBox(height: 20.0),

        // Category
        const Text(
          'Category',
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}
