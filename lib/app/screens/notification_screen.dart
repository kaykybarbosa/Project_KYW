import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';
import 'package:kyw_management/app/widgets/my_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      arrowBack: () {
        context.pop(context);
      },
      title: 'Notificações',
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
