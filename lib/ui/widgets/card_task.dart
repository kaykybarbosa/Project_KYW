import 'package:flutter/material.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/dtos/response/all_tasks_response.dart';
import 'package:kyw_management/ui/widgets/my_card_status.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class CardTask extends StatelessWidget {
  const CardTask({
    super.key,
    required this.task,
    this.onTap,
  });

  final TaskResponse task;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 2.5),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 6,
            ),
          ),
          borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: TColors.base900.withOpacity(.16),
              blurRadius: TConstants.blurRadius,
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: const BoxDecoration(
              color: TColors.base100,
              border: Border(
                top: BorderSide(color: TColors.base200),
                right: BorderSide(color: TColors.base200),
                bottom: BorderSide(color: TColors.base200),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(TConstants.radiusLeftInput),
                bottomLeft: Radius.circular(TConstants.radiusLeftInput),
                topRight: Radius.circular(TConstants.cardRadiusXs),
                bottomRight: Radius.circular(TConstants.cardRadiusXs),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Nome
                _TaskName(task: task),

                /// Descrição
                _TaskDescription(task: task),

                /// Categoria e Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    /// -- Título
                    const Text(
                      'Status',
                      style: TextStyle(fontSize: TConstants.fontSizeMd),
                    ),

                    /// -- Status
                    MyCardStatus(status: task.status)
                  ],
                )
              ],
            ),
          ),
        ),
      );
}

class _TaskName extends StatelessWidget {
  const _TaskName({required this.task});

  final TaskResponse task;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /// Nome
          Text(
            '${task.description}',
            style: const TextStyle(
              fontSize: TConstants.fontSizeLg,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// Ícone
          Icon(
            task.pin ? TIcons.isImportant : null,
            size: TConstants.iconSm + 3,
            color: TColors.base200,
          ),
        ],
      );
}

class _TaskDescription extends StatelessWidget {
  const _TaskDescription({required this.task});

  final TaskResponse task;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 35),
        child: Text(
          '${task.description}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: TConstants.fontSizeMd,
            color: TColors.base200,
          ),
        ),
      );
}
