import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/screens/home/widgets/drawer/my_end_drawer.dart';
import 'package:kyw_management/ui/screens/home/widgets/home_appbar.dart';
import 'package:kyw_management/ui/screens/home/widgets/project_list.dart';
import 'package:kyw_management/ui/screens/home/widgets/task_list.dart';
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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

            /// Telas de Projetos e Tasks
            body: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const <Widget>[
                      /// -- Projetos
                      ProjectList(),

                      /// -- Tasks
                      TaskList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


  //                     onTap: () => myModalBottom(
  //                       context: context,
  //                       state: state,
  //                       child: MyOrder(currentScreen: state.currentScreen),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),

