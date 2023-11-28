import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/models/project.dart';

class CardProject extends StatefulWidget {
  const CardProject({
    super.key,
    required this.project,
    this.onTap,
  });

  final Project project;
  final Function? onTap;

  @override
  State<CardProject> createState() => _CardProjectState();
}

class _CardProjectState extends State<CardProject> {
  Widget _getImage() {
    if (widget.project.image != null) {
      return Image.asset(
        widget.project.image!,
        width: 55.0,
      );
    } else {
      return Container(
        color: CupertinoColors.systemGrey,
        padding: const EdgeInsets.all(12.0),
        child: const Icon(
          CupertinoIcons.group_solid,
          size: 29.0,
          color: CupertinoColors.systemGrey5,
        ),
      );
    }
  }

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
                child: _getImage(),
              ),
              Row(
                children: [
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Group name
                      Text(
                        widget.project.name,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: CupertinoTheme.of(context).primaryColor,
                        ),
                      ),

                      // Last message send
                      Text(
                        widget.project.lastMessage ?? '',
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
                          widget.project.lastMessageTime ?? '',
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
                          widget.project.isImportant
                              ? Icons.push_pin_rounded
                              : null,
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
