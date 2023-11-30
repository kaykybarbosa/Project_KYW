import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/widgets/my_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notificações',
          style: TextStyle(fontSize: 25.0, color: CupertinoColors.white),
        ),
        backgroundColor: CupertinoTheme.of(context).primaryColor,
      ),
      body: const Column(
        children: [
          MyNotification(),
          Divider(),
          MyNotification(),
          Divider(),
          MyNotification(),
          Divider(),
        ],
      ),
    );
  }
}
