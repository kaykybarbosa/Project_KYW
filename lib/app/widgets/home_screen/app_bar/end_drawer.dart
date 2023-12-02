import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/widgets/circle_image.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: CupertinoTheme.of(context).primaryColor,
      // surfaceTintColor: CupertinoColors.activeBlue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              color: CupertinoTheme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleImage(
                    iconSize: 30.0,
                    padding: const EdgeInsets.all(18.0),
                    changeIconVisible: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const ListTile(
            title: Text('data'),
          ),
        ],
      ),
    );
  }
}
