import 'package:flutter/material.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/ui/widgets/my_status.dart';

class FilterByCheckedBox extends StatelessWidget {
  const FilterByCheckedBox({
    super.key,
    this.status,
    required this.onChanged,
    this.isChecked,
    this.statusIsVisible = true,
  });

  final bool? isChecked;
  final TaskStatus? status;
  final bool statusIsVisible;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) => onChanged(value),
        ),
        Visibility(
          visible: statusIsVisible,
          child: MyStatus(status: status ?? TaskStatus.incomplete),
        )
      ],
    );
  }
}
