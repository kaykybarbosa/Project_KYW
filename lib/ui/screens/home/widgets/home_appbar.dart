import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/home/home_screen.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_action_icon.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var homeState = context.findAncestorStateOfType<HomeScreenState>();

    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverSafeArea(
        top: false,
        sliver: SliverAppBar(
          pinned: true,
          floating: true,
          snap: true,
          title: const _AppName(),
          actions: <Widget>[
            MyActionIcon(
              icon: TIcons.bell,
              onTap: () => Get.toNamed(AppRoutes.notifications),
            ),
            MyActionIcon(
              showBadge: false,
              icon: TIcons.more,
              onTap: () => homeState?.openEndDrawer(),
            ),
          ],
          bottom: TabBar(
            indicatorWeight: 3,
            controller: homeState?.tabController,
            labelStyle: const TextStyle(fontSize: TConstants.fontSizeMd),
            tabs: const [
              Tab(text: 'Projetos'),
              Tab(text: 'Tasks'),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName();

  @override
  Widget build(BuildContext context) => const Text(
        'KYW',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: TConstants.fontSizeMd + 2,
        ),
      );
}
