import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});

  final List<String> optionsTitle = [
    'Central de ajuda',
    'Fale conosco',
    'Dados do aplicativo',
  ];

  final List<IconData> optionsIcons = [
    FontAwesomeIcons.shieldHalved,
    FontAwesomeIcons.commentDots,
    FontAwesomeIcons.circleInfo,
  ];
  @override
  Widget build(BuildContext context) {
    void goHelpCenter() {}

    void goContactUs() => Get.toNamed(AppRoutes.contactUs);

    void goApplicationData() {}

    final List<Function> optionsFunction = [
      /// If [index] == 0, show HelpCenterScreen
      /// If [index] == 1, show ContactUsScreen
      /// If [index] == 2, show ApplicationDataScreen

      goHelpCenter,
      goContactUs,
      goApplicationData
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Ajuda')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              optionsFunction[index]();
            },
            leading: Icon(
              optionsIcons[index],
              color: CupertinoTheme.of(context).primaryColor,
            ),
            title: Text(
              optionsTitle[index],
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ),
          );
        },
        separatorBuilder: (__, _) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Divider(height: 0.0),
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: optionsTitle.length,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
