import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/widgets/my_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, BuildContext? context});

  @override
  Widget build(context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 19.0),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            color: CupertinoColors.activeBlue,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.back,
                      size: 33.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Notification',
                      style: TextStyle(fontSize: 27.0),
                    ),
                  ],
                ),
                Icon(CupertinoIcons.ellipsis_vertical)
              ],
            ),
          ),
          const MyNotification(),
          const Divider(),
          const MyNotification(),
          const Divider(),
          const MyNotification(),
          const Divider(),
        ],
      ),
    );
  }
}
