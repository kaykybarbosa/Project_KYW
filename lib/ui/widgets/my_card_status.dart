import 'package:flutter/cupertino.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MyCardStatus extends StatelessWidget {
  MyCardStatus({super.key, required this.status});

  final TaskStatus status;

  final Map<TaskStatus, Color> color = {
    TaskStatus.complete: TColors.success,
    TaskStatus.incomplete: TColors.alert,
    TaskStatus.pending: TColors.warn,
  };

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: color[status]!.withOpacity(.2502),
              borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 10.0,
            ),
            child: Text(
              status.name,
              style: TextStyle(
                color: color[status],
                fontSize: TConstants.fontSizeLg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
