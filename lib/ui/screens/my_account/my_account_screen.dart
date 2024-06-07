import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';
import 'package:kyw_management/ui/widgets/circle_image.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  static final CurrentUserModel _currentUser = AppController.instance.currentUser;

  static final List<Map<String, dynamic>> options = [
    {
      'title': 'Nome',
      'label': _currentUser.nickname,
      'icon': TIcons.solidUser,
    },
    {
      'title': 'E-mail',
      'label': _currentUser.email,
      'icon': TIcons.email,
    },
    {
      'title': 'Telefone',
      'label': '+55 98 4004-8922',
      'icon': TIcons.phone,
    },
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Minha Conta')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),

            // Profile image
            const CircleImage.medium(
              icon: TIcons.solidUser,
              iconWithPadding: false,
            ),

            // Informations the user
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(
                    options[index]['icon'],
                    color: CupertinoColors.systemGrey3,
                    size: 22.0,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        options[index]['title'],
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: CupertinoColors.systemGrey2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Label
                      Text(
                        options[index]['label'],
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(50, 58, 71, 1),
                        ),
                      ),
                    ],
                  ),
                  trailing: _ChangeDataIcon(
                    onTap: () {},
                  ),
                ),
                separatorBuilder: (__, _) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(height: 0.0),
                ),
                itemCount: options.length,
                padding: EdgeInsets.zero,
              ),
            )
          ],
        ),
      );
}

class _ChangeDataIcon extends StatelessWidget {
  const _ChangeDataIcon({this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Stack(
          alignment: const Alignment(2.4, -2.4),
          children: <Widget>[
            Container(
              width: 18.0,
              height: 18.0,
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                color: TColors.base100,
                border: Border.all(color: TColors.base200),
                borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
              ),
              child: const SizedBox(),
            ),
            const Icon(
              TIcons.pen,
              size: TConstants.iconXs + 2,
              color: TColors.primary,
            ),
          ],
        ),
      );
}
