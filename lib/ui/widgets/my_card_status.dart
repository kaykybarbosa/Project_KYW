import 'package:flutter/cupertino.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MyCardStatus extends StatelessWidget {
  MyCardStatus({
    super.key,
    required this.status,
    this.fontSize = TConstants.fontSizeMd,
  });

  final TaskStatus status;
  final double fontSize;

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
              status.label,
              style: TextStyle(
                color: color[status],
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
