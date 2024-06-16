import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/utils/icons.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});

  final List<Map<String, dynamic>> options = [
    {
      'label': 'Central de ajuda',
      'icon': TIcons.security,
      'onTap': () => {},
    },
    {
      'label': 'Fale conosco',
      'icon': TIcons.comments,
      'onTap': () => Get.toNamed(AppRoutes.contactUs),
    },
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Ajuda')),
        body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            onTap: options[index]['onTap'],
            leading: Icon(options[index]['icon']),
            title: Text(
              options[index]['label'],
              style: const TextStyle(
                fontSize: TConstants.fontSizeLg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          separatorBuilder: (__, _) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(height: 0.0),
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          padding: EdgeInsets.zero,
        ),
      );
}
