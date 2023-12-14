import 'package:flutter/material.dart';
import 'package:kyw_management/app/widgets/my_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return const MyNotification(
            message:
                'Existem muitas variações de passagens de Lorem Ipsum disponíveis, mas a maioria sofreu alterações de alguma forma de tomar atitudes',
            time: '1 de nov de 2023 as 10:50',
          );
        },
        separatorBuilder: (__, _) => const Divider(
          color: Colors.grey,
        ),
        itemCount: 3,
      ),
    );
  }
}
