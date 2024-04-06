import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/ui/widgets/my_status.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Theme.of(context).primaryColor, width: 6)),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.2,
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: const Border(
            top: BorderSide(color: Colors.grey),
            right: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Task name
                Text(
                  widget.task.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  widget.task.isImportant ? FontAwesomeIcons.thumbtack : null,
                  size: 23,
                  color: CupertinoColors.systemGrey2,
                ),
              ],
            ),
            // Task description
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 35),
              child: Text(
                widget.task.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Task category
                const Text(
                  'Categoria',
                  style: TextStyle(fontSize: 17),
                ),
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
