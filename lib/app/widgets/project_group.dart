import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectGroup extends StatefulWidget {
  ProjectGroup(
      {super.key,
      required this.name,
      this.onTap,
      this.image,
      this.lastMessage,
      this.lastMessageTime,
      this.isImportant = false});

  String name;
  Function? onTap;
  Image? image;
  String? lastMessage;
  String? lastMessageTime;
  bool isImportant;

  @override
  State<ProjectGroup> createState() => _ProjectGroupState();
}

class _ProjectGroupState extends State<ProjectGroup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap;
      },
      child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group image
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: widget.image ??
                    Container(
                      color: CupertinoColors.systemGrey,
                      padding: const EdgeInsets.all(12.0),
                      child: const Icon(
                        CupertinoIcons.group_solid,
                        size: 30.0,
                        color: CupertinoColors.systemGrey5,
                      ),
                    ),
              ),
              Row(
                children: [
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Group name
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: CupertinoTheme.of(context).primaryColor,
                        ),
                      ),

                      // Last message send
                      Text(
                        widget.lastMessage ?? '',
                        style: const TextStyle(
                          fontSize: 17.0,
                          color: CupertinoColors.systemGrey2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    // Last message time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.lastMessageTime ?? '',
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6.0),

                    // IsImportant
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          widget.isImportant ? Icons.push_pin_rounded : null,
                          color: CupertinoColors.systemGrey2,
                          size: 27.0,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
