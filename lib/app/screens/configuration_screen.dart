import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';
import 'package:kyw_management/app/widgets/configuration_screen/config_option.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ConfigOption> options = [
      ConfigOption(
        icon: FontAwesomeIcons.user,
        title: 'Conta',
        subTitle: 'Configurações da conta',
        onTap: () {
          context.push(MyRoutes.configurationAccount);
        },
      ),
      ConfigOption(
        icon: FontAwesomeIcons.bell,
        title: 'Notificações',
        subTitle: 'Notificações do app',
        onTap: () {},
      ),
      ConfigOption(
        icon: FontAwesomeIcons.question,
        title: 'Ajuda',
        subTitle: 'Entre em contato',
        onTap: () {},
      ),
    ];

    return MyScaffold(
      arrowBack: () {
        context.pop(context);
      },
      title: 'Configurações',
      body: ListView.separated(
        itemBuilder: (context, index) {
          return options[index];
        },
        separatorBuilder: (__, _) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          child: Divider(height: 0.0),
        ),
        itemCount: options.length,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
