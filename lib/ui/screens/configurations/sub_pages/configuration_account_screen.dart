import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class ConfigurationAccountScreen extends StatelessWidget {
  const ConfigurationAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> options = [
      {
        'label': 'Configuração de duas etapas',
        'icon': TIcons.security,
        'onTap': () => Get.toNamed(AppRoutes.twoStepVerification),
      },
      {
        'label': 'Apagar conta',
        'icon': TIcons.trash,
        'color': TColors.warn,
        'onTap': () => Get.toNamed(AppRoutes.configurationDeleteAccount),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Conta')),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          leading: Icon(
            options[index]['icon'],
            color: options[index]['color'],
          ),
          title: Text(
            options[index]['label'],
            style: const TextStyle(
              fontSize: TConstants.fontSizeLg,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: options[index]['onTap'],
        ),
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          child: Divider(),
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
