import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/home/widgets/drawer/sign_out_button.dart';
import 'package:kyw_management/ui/widgets/circle_image.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DrawerOption> options = [
      /// Configurações
      DrawerOption(
        icon: TIcons.configurations,
        label: TTexts.configurations,
        onTap: () => Get.toNamed(AppRoutes.configuration),
      ),

      // Minha conta
      DrawerOption(
        icon: TIcons.user,
        label: TTexts.myAccount,
        onTap: () => Get.toNamed(AppRoutes.myAccount),
      ),

      // Ajuda
      DrawerOption(
        icon: TIcons.info,
        label: TTexts.help,
        onTap: () => Get.toNamed(AppRoutes.help),
      ),
    ];

    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      width: 270.0,
      child: Column(
        children: <Widget>[
          /// Header
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Imagem de perfil
                  CircleImage(
                    iconSize: TConstants.iconLg - 3,
                    padding: const EdgeInsets.all(18.0),
                    changeIconVisible: false,
                    onTap: () {},
                  ),

                  /// Nome do usuário
                  const Text(
                    'Joãozin',
                    style: TextStyle(
                      color: TColors.base100,
                      fontWeight: FontWeight.bold,
                      fontSize: TConstants.fontSizeLg,
                    ),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              color: TColors.base100,
              child: Column(
                children: <Widget>[
                  /// Opções
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (__, _) => const Divider(height: 0.0),
                      itemBuilder: (context, index) => options[index],
                    ),
                  ),

                  /// Sair do app
                  SignOutButton(onTap: () => Get.offAllNamed(AppRoutes.signIn)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        leading: Icon(
          icon,
          color: TColors.primary,
          size: TConstants.iconSm + 4,
        ),
        title: Text(
          label,
          style: const TextStyle(fontSize: TConstants.fontSizeLg),
        ),
      );
}
