import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/widgets/circle_image.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/drawer_option.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/sign_out_button.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DrawerOption> options = [
      DrawerOption(
        icon: Icons.settings,
        label: 'Configurações',
        onTap: () {
          context.push(MyRoutes.configuration);
        },
      ),

      // My account
      DrawerOption(
        icon: FontAwesomeIcons.solidUser,
        label: 'Minha conta',
        onTap: () {
          context.push(MyRoutes.myAccount);
        },
      ),

      // Help
      DrawerOption(
        icon: FontAwesomeIcons.circleInfo,
        label: 'Ajuda',
        onTap: () {
          context.push(MyRoutes.help);
        },
      ),
    ];

    return Drawer(
      width: 270.0,
      child: Column(
        children: [
          // Header
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile image
                  CircleImage(
                    iconSize: 30.0,
                    padding: const EdgeInsets.all(18.0),
                    changeIconVisible: false,
                    onTap: () {},
                  ),

                  // Nick name
                  const Text(
                    'Joãozin',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ),
          ),

          // Options the configuration
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (__, _) => const Divider(height: 0.0),
              itemBuilder: (context, index) {
                return options[index];
              },
            ),
          ),

          // SingOut
          SignOutButton(
              onTap: () =>
                  GoRouter.of(context).pushReplacement(MyRoutes.signIn)),

          const SizedBox(height: 50.0)
        ],
      ),
    );
  }
}
