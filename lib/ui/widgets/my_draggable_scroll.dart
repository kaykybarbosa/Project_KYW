import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/utils/colors.dart';

class MyDraggableScroll extends StatelessWidget {
  const MyDraggableScroll({
    super.key,
    required this.child,
    this.header,
    this.padding,
  });

  final Widget child;
  final Widget? header;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
        initialChildSize: .7,
        minChildSize: .4,
        maxChildSize: .95,
        builder: (_, controller) => Container(
          padding: padding ?? const EdgeInsets.only(left: 25, top: 25, right: 25),
          decoration: const BoxDecoration(
            color: TColors.base100,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: <Widget>[
              header ?? Container(),
              const Gap(5),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      );
}
