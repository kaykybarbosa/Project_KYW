import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupProject extends StatefulWidget {
  GroupProject({super.key, this.context});

  BuildContext? context;

  @override
  State<GroupProject> createState() => _GroupProjectState();
}

class _GroupProjectState extends State<GroupProject> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6.0),
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
          color: CupertinoColors.systemGrey6,
          border: Border.all(color: CupertinoColors.systemGrey4),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/casa-na-arvore.webp',
                width: 50.0,
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name the Group
                    Text(
                      'Casa na Árvore',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                    ),

                    // Last message send
                    const Text(
                      'última mensagem envia...',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: CupertinoColors.systemGrey2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Expanded(
              child: Column(
                children: [
                  // Time the last message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '15:30',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: CupertinoColors.systemGrey2,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.0),

                  // IsImportant
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.push_pin_rounded,
                        color: CupertinoColors.systemGrey2,
                        size: 27.0,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
