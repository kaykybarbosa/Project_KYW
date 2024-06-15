import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/configurations/widgets/config_option.dart';
import 'package:kyw_management/utils/icons.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ConfigOption> options = [
      ConfigOption(
        icon: TIcons.user,
        title: 'Conta',
        subTitle: 'Configurações da conta',
        onTap: () => Get.toNamed(AppRoutes.configurationAccount),
      ),
      ConfigOption(
        icon: TIcons.bell,
        title: 'Notificações',
        subTitle: 'Notificações do app',
        onTap: () {},
      ),
      ConfigOption(
        icon: TIcons.question,
        title: 'Ajuda',
        subTitle: 'Entre em contato',
        onTap: () => Get.toNamed(AppRoutes.help),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView.separated(
        itemBuilder: (context, index) => options[index],
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          child: Divider(),
        ),
        itemCount: options.length,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
