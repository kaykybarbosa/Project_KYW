import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/utils/colors.dart';

class ConfigurationAccountScreen extends StatelessWidget {
  const ConfigurationAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> optionsTitle = [
      'Configuração de duas etapas',
      'Mudar Número ou E-mail',
      'Apagar conta',
    ];
    final List<IconData> optionsIcon = [
      FontAwesomeIcons.shieldHalved,
      FontAwesomeIcons.phoneFlip,
      FontAwesomeIcons.solidTrashCan
    ];

    void goTwoStepVerification() => Get.toNamed(AppRoutes.twoStepVerification);

    void goChangeNumberOrEmail() => Get.toNamed(AppRoutes.changeNumberOrEmail);

    void deleteAccount() => Get.toNamed(AppRoutes.configurationDeleteAccount);

    List<Function> optionsFunction = [
      /// If [index] == 0 => show two_step_screen
      /// If [index] == 1 => show change_number_screen
      /// If [index] == 0 => show delete_account_screen

      goTwoStepVerification,
      goChangeNumberOrEmail,
      deleteAccount
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Conta')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              optionsIcon[index],
              color: index != 2 ? TColors.secondary : CupertinoColors.destructiveRed,
            ),
            title: Text(
              optionsTitle[index],
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: TColors.secondary,
              ),
            ),
            onTap: () {
              optionsFunction[index]();
            },
          );
        },
        separatorBuilder: (__, _) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          child: Divider(height: 0.0),
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: optionsTitle.length,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
