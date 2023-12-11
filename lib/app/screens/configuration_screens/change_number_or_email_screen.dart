import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';

class ChangeNumberOrEmail extends StatelessWidget {
  const ChangeNumberOrEmail({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(50, 58, 71, 1);

    final List<String> optionsTitle = [
      'Mudar Número',
      'Mudar E-mail',
    ];

    final List<IconData> optionsIcon = [
      FontAwesomeIcons.squarePhoneFlip,
      FontAwesomeIcons.envelope,
    ];

    return MyScaffold(
      arrowBack: () => GoRouter.of(context).pop,
      title: 'Mudar Número ou E-mail',
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: index == 0
                ? Transform.rotate(
                    angle: (-270 * 3.14159 / 180),
                    child: Icon(optionsIcon[index]),
                  )
                : Icon(optionsIcon[index]),
            title: Text(
              optionsTitle[index],
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          );
        },
        separatorBuilder: (__, _) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          child: Divider(height: 0.0),
        ),
        itemCount: optionsTitle.length,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
