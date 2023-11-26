import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/widgets/group_project.dart';
import 'package:kyw_management/app/widgets/my_navigator.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool wasPressed = true;
  Color itemsBarColor = CupertinoColors.lightBackgroundGray;

  BoxDecoration _decoration = MyDecorations.inputDecoration(borderRadius: 20.0);

  setDecoration({double borderRadius = 20.0, bool isActive = true}) {
    setState(() {
      _decoration = MyDecorations.inputDecoration(
        borderRadius: borderRadius,
        isActice: isActive,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // My appBar
        appBar: myAppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 15.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    // Input Search
                    Expanded(
                      child: CupertinoTextField(
                        placeholder: 'Buscar task',
                        decoration: _decoration,
                        style: MyDecorations.inputTextStyle(fontSize: 19.0),
                        onTap: () {
                          setDecoration(isActive: true);
                        },
                        onEditingComplete: () {
                          setDecoration(isActive: false);
                        },
                      ),
                    ),

                    // Icon Search
                    Container(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(left: 10.0),
                      height: 38.0,
                      width: 38.0,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.search,
                          size: 23.0,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15.0),

                // Buttons the filter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filterButton(
                      onTap: () {},
                      label: 'Filtrar',
                      icon: Icons.filter_list_alt,
                    ),
                    filterButton(
                      onTap: () {},
                      label: 'Ordenar',
                      icon: CupertinoIcons.chevron_down,
                      size: 23.0,
                    ),
                  ],
                ),

                const SizedBox(height: 18.0),

                // Groups Project
                GroupProject()
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget myAppBar() {
    return AppBar(
      title: Column(
        children: [
          // First part to appBar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'KYW',
                  style: TextStyle(
                    color: itemsBarColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Icons to right
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Badge(
                      label: const Text('2'),
                      child: myIcon(CupertinoIcons.bell),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  GestureDetector(
                      child: myIcon(CupertinoIcons.ellipsis_vertical)),
                ],
              ),
            ],
          ),
          // Navigation to Projects and Task
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
      backgroundColor: CupertinoTheme.of(context).primaryColor,
      toolbarHeight: 80.0,
      elevation: 0,
    );
  }

  Icon myIcon(IconData icon) {
    return Icon(
      icon,
      color: itemsBarColor,
      size: 21.0,
    );
  }

  GestureDetector filterButton(
      {required Function onTap, String? label, IconData? icon, double? size}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: CupertinoColors.systemGrey2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label ?? '',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 5.0),
            Icon(
              icon,
              color: CupertinoColors.systemGrey2,
              size: size,
            ),
          ],
        ),
      ),
    );
  }
}
