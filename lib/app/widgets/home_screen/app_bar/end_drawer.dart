import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/widgets/circle_image.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/drawer_option.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/sign_out_button.dart';

class MyEndDrawer extends StatefulWidget {
  MyEndDrawer({super.key});

  @override
  State<MyEndDrawer> createState() => _MyEndDrawerState();
}

class _MyEndDrawerState extends State<MyEndDrawer> {
  @override
  Widget build(BuildContext context) {
    final List<DrawerOption> _options = [
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Header
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Container(
                    color: CupertinoTheme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              ],
            ),
          ),

          // Options the configuration
          Expanded(
            flex: 7,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                    color: CupertinoColors.activeBlue, child: _options[index]);
              },
              separatorBuilder: (__, _) => const Divider(height: 0.0),
              itemCount: _options.length,
            ),
          ),

          // SingOut
          SignOutButton(onTap: () {}),

          const SizedBox(height: 50.0)
        ],
      ),
    );
  }
}
