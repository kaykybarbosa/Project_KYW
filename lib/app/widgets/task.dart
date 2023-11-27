import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/enums/status.dart';

class Task extends StatefulWidget {
  Task(
      {super.key,
      required this.title,
      this.description,
      this.isImportant = false,
      this.status = Status.incomplete});

  String title;
  String? description;
  bool isImportant;
  Status status;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Map<Status, Color> color = {
    Status.complete: CupertinoColors.systemGreen,
    Status.incomplete: CupertinoColors.systemYellow,
    Status.pending: CupertinoColors.systemRed,
  };

  Map<Status, Color> backgroundColor = {
    Status.complete: const Color.fromARGB(40, 52, 199, 89),
    Status.incomplete: const Color.fromARGB(40, 255, 204, 0),
    Status.pending: const Color.fromARGB(40, 255, 58, 48),
  };

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
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Task description
                  Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      widget.description ?? '',
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
                    'Category',
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
                      widget.isImportant ? Icons.push_pin_rounded : null,
                      size: 27.0,
                      color: CupertinoColors.systemGrey2,
                    ),
                  ],
                ),

                const SizedBox(height: 60.0),

                // Status name
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor[widget.status],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        widget.status.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: color[widget.status],
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
