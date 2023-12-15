import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/widgets/my_status.dart';

class FilterByCheckedBox extends StatelessWidget {
  const FilterByCheckedBox(
      {super.key,
      this.status,
      required this.onChanged,
      this.isChecked,
      this.statusIsVisible = true});

  final Function onChanged;
  final bool? isChecked;
  final Status? status;
  final bool statusIsVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1,
          child: Checkbox(
            value: isChecked,
            onChanged: (bool? value) => onChanged(value),
          ),
        ),
        Visibility(
          visible: statusIsVisible,
          child: MyStatus(status: status ?? Status.incomplete),
        )
      ],
    );
  }
}
