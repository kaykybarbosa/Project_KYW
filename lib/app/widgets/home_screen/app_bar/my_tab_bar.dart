import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget myTabBar({
  required Function onTap,
  required List<Tab> tabs,
}) {
  return TabBar(
    tabs: tabs,
    onTap: (value) {
      onTap(value);
    },
    labelStyle: const TextStyle(
      color: CupertinoColors.white,
      fontSize: 18.0,
    ),
    dividerHeight: 0,
    enableFeedback: false,
    overlayColor:
        MaterialStateProperty.all(const Color.fromARGB(59, 242, 242, 247)),
    unselectedLabelColor: CupertinoColors.white,
    indicatorColor: CupertinoColors.white,
    indicatorWeight: 4.0,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorPadding: const EdgeInsets.symmetric(horizontal: 35.0),
  );
}
