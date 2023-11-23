import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/widgets/my_navigator.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool wasPressed = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: CupertinoTheme.of(context).primaryColor,
                boxShadow: const [
                  BoxShadow(
                      color: CupertinoColors.inactiveGray,
                      offset: Offset(0, 3),
                      blurRadius: 1,
                      spreadRadius: 1)
                ]),
            height: 100,
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'KYW',
                        style: TextStyle(
                            color: CupertinoColors.lightBackgroundGray),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.bell,
                          color: CupertinoColors.lightBackgroundGray,
                        ),
                        SizedBox(width: 15),
                        Icon(
                          CupertinoIcons.ellipsis_vertical,
                          color: CupertinoColors.lightBackgroundGray,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyNavigator(
                      onTap: () => setState(() {
                        wasPressed = !wasPressed;
                      }),
                      title: 'Projects',
                      wasPressed: wasPressed,
                    ),
                    MyNavigator(
                      onTap: () => setState(() {
                        wasPressed = !wasPressed;
                      }),
                      title: 'Tasks',
                      wasPressed: !wasPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              CupertinoTextField(
                placeholder: 'Buscar',
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.black)),
              )
            ],
          )
        ],
      ),
    );
  }
}
