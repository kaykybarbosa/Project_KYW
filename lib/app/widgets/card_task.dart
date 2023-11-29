import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/widgets/my_status.dart';

class CardTask extends StatefulWidget {
  const CardTask({super.key, required this.task});

  final Task task;

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: CupertinoColors.systemGrey4),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Task name
                  Text(
                    widget.task.title,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Task description
                  Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      widget.task.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5.0),

                  //Task category
                  const Text(
                    'Categoria',
                    style: TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // isImportant
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      widget.task.isImportant ? Icons.push_pin_rounded : null,
                      size: 27.0,
                      color: CupertinoColors.systemGrey2,
                    ),
                  ],
                ),

                const SizedBox(height: 60.0),

                // Status name
                MyStatus(status: widget.task.status)
              ],
            )
          ],
        ),
      ),
    );
  }
}
