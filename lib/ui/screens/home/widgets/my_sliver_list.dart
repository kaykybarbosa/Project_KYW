import 'package:flutter/material.dart';
import 'package:kyw_management/utils/constants.dart';

class MySliverList extends StatelessWidget {
  const MySliverList({
    super.key,
    required this.childCount,
    this.padding,
    required this.builder,
  });

  final int childCount;
  final EdgeInsetsGeometry? padding;
  final Widget? Function(BuildContext, int) builder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) => CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverPadding(
              padding: padding ??
                  const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: TConstants.defaultMargin,
                  ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  builder,
                  childCount: childCount,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
