import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/widgets/my_status.dart';

class FilterByStatus extends StatelessWidget {
  const FilterByStatus({
    super.key,
    required this.status,
    required this.onChanged,
    required this.isChecked,
  });

  final Function onChanged;
  final bool isChecked;
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1,
          child: Checkbox(
            value: isChecked,
            checkColor: CupertinoColors.white,
            overlayColor: MaterialStateProperty.all(Colors.grey[200]),
            activeColor: CupertinoColors.systemGrey,
            onChanged: (bool? value) {
              onChanged(value);
            },
          ),
        ),
        MyStatus(status: status)
      ],
    );
  }
}
