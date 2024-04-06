import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/screens/home/widgets/drawer/my_end_drawer.dart';
import 'package:kyw_management/ui/screens/home/widgets/home_appbar.dart';
import 'package:kyw_management/ui/screens/home/widgets/project_list.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/home_bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() => setCurrentScreen());
  }

  void setCurrentScreen() {
    /// [value] == 0 => ShowMyProjects and
    /// [value] == 1 => ShowMyTasks

    if (tabController.index == 0) {
      context.read<HomeBloc>().add(const ScreenChangedHome(screen: Screens.project));
    } else {
      context.read<HomeBloc>().add(const ScreenChangedHome(screen: Screens.task));
    }
  }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void resetBlocCurrentScreen(Screens screen) {
    if (screen == Screens.project) {
      context.read<FilterProjectBloc>().add(ResetFilterProject());
    } else {
      context.read<FilterTaskBloc>().add(ResetFilterTask());
    }
  }

  Future<dynamic> myModalBottom({
    required BuildContext context,
    required HomeState state,
    required Widget child,
  }) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      builder: (BuildContext context) => SizedBox(
        height: 665,
        child: child,
      ),
    );

    resetBlocCurrentScreen(state.currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const MyEndDrawer(),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, index) => [
          /// AppBar
          const HomeAppBar(),
        ],
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  ProjectList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  //         key: scaffoldKey,
  //         appBar: const HomeAppBar(),
  //         body: Column(
  //           children: [
  //             // Input Search
  //             Padding(
  //               padding: const EdgeInsets.only(left: 15, top: 12, right: 15),
  //               child: MySearchBar(search: () {}),
  //             ),

  //             // Buttons the filters
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 15),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   // Filter
  //                   TheFilters(
  //                     label: 'Filtrar',
  //                     labelSize: 17,
  //                     iconSize: 17,
  //                     icon: FontAwesomeIcons.filter,
  //                     onTap: () => myModalBottom(
  //                       context: context,
  //                       state: state,
  //                       child: MyFilter(currentScreen: state.currentScreen),
  //                     ),
  //                   ),

  //                   // Order
  //                   TheFilters(
  //                     label: 'Ordenar',
  //                     labelSize: 17,
  //                     icon: FontAwesomeIcons.caretDown,
  //                     iconSize: 26,
  //                     onTap: () => myModalBottom(
  //                       context: context,
  //                       state: state,
  //                       child: MyOrder(currentScreen: state.currentScreen),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),

  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 7.5),
  //                 child: TabBarView(
  //                   controller: tabController,
  //                   children: const [
  //                     // Projects screen
  //                     ListProjects(),

  //                     // Tasks screens
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 0),
  //                       child: ListTasks(tasks: []),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),

  //         // EndDrawer the more options
  //         endDrawer: const MyEndDrawer(),

  //         // Button create project
  //         floatingActionButton: state.currentScreen == Screens.project
  //             ? CreateProjectButton(onTap: () => Get.toNamed(AppRoutes.createProject))
  //             : null,
  //       );
  //     },
  //   );
  // }
