import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';
import 'package:kyw_management/app/widgets/circle_image.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({super.key});

  final List<String> optionsTitle = const ['Nome', 'E-mail', 'Telefone'];
  final List<String> optionsLabel = const [
    'Joãozin',
    'joao@gmail.com',
    '+55 98 4004-8922'
  ];
  final List<IconData> optionsIcon = const [
    FontAwesomeIcons.solidUser,
    FontAwesomeIcons.solidEnvelope,
    FontAwesomeIcons.phone
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      arrowBack: () {
        Navigator.pop(context);
      },
      title: 'Minha Conta',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),

          // Profile image
          CircleImage(onTap: () {}),

          // Informations the user
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    optionsIcon[index],
                    color: CupertinoColors.systemGrey3,
                    size: 22.0,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        optionsTitle[index],
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: CupertinoColors.systemGrey2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Label
                      Text(
                        optionsLabel[index],
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(50, 58, 71, 1),
                        ),
                      ),
                    ],
                  ),
                  trailing: Stack(
                    alignment: const Alignment(2.4, -2.4),
                    children: [
                      Container(
                        width: 18.0,
                        height: 18.0,
                        padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            border:
                                Border.all(color: CupertinoColors.systemGrey),
                            borderRadius: BorderRadius.circular(6.0)),
                        child: const Text(''),
                      ),
                      const Icon(
                        FontAwesomeIcons.pen,
                        size: 14.0,
                        color: CupertinoColors.systemBlue,
                      ),
                    ],
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (__, _) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(height: 0.0),
              ),
              itemCount: optionsTitle.length,
              padding: EdgeInsets.zero,
            ),
          )
        ],
      ),
    );
  }
}
