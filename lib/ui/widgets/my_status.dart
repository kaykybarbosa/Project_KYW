import 'package:flutter/cupertino.dart';
import 'package:kyw_management/domain/enums/status.dart';

class MyStatus extends StatelessWidget {
  MyStatus({super.key, required this.status});

  final Status status;

  final Map<Status, Color> color = {
    Status.complete: CupertinoColors.systemGreen,
    Status.incomplete: CupertinoColors.systemYellow,
    Status.pending: CupertinoColors.systemRed,
  };

  final Map<Status, Color> backgroundColor = {
    Status.complete: const Color.fromARGB(40, 52, 199, 89),
    Status.incomplete: const Color.fromARGB(40, 255, 204, 0),
    Status.pending: const Color.fromARGB(40, 255, 58, 48),
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor[status],
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            status.name,
            style: TextStyle(
              fontSize: 18.0,
              color: color[status],
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
