import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/data/tasks.dart';
import 'package:kyw_management/app/enums/screens.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/app_name.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/end_drawer.dart';
import 'package:kyw_management/app/widgets/home_screen/create_project_button.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/my_filter.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/my_order.dart';
import 'package:kyw_management/app/widgets/home_screen/my_icon.dart';
import 'package:kyw_management/app/widgets/home_screen/my_search_bar.dart';
import 'package:kyw_management/app/widgets/home_screen/the_filters.dart';
import 'package:kyw_management/app/widgets/list_projects.dart';
import 'package:kyw_management/app/widgets/list_tasks.dart';
import 'package:kyw_management/domain/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/domain/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/domain/blocs/home_bloc/home_bloc.dart';
import 'package:kyw_management/domain/services/routers/my_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setCurrentScreen());
  }

  void setCurrentScreen() {
    /// [value] == 0 => ShowMyProjects and
    /// [value] == 1 => ShowMyTasks

    if (_tabController.index == 0) {
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
          appBar: AppBar(
            toolbarHeight: 50,
            // App name
            leading: AppName(color: Theme.of(context).colorScheme.onPrimary),
            actions: [
              // Messages Icon
              MyIcon(
                icon: CupertinoIcons.bell,
                onTap: () {
                  GoRouter.of(context).push(AppRoutes.notifications);
                  context.read<HomeBloc>().add(const HaveMessageHome(haveMessage: false));
                },
              ),

              // More options Icon
              MyIcon(
                icon: CupertinoIcons.ellipsis_vertical,
                onTap: () => openEndDrawer(),
                showBadge: false,
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Projetos'),
                Tab(text: 'Tarefas'),
              ],
              labelStyle: const TextStyle(fontSize: 18),
            ),
          ),

          body: Column(
            children: [
              // Input Search
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 12, right: 15),
                child: MySearchBar(search: () {}),
              ),

              // Buttons the filters
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Filter
                    TheFilters(
                      label: 'Filtrar',
                      labelSize: 17,
                      iconSize: 17,
                      icon: FontAwesomeIcons.filter,
                      onTap: () => myModalBottom(
                        context: context,
                        state: state,
                        child: MyFilter(currentScreen: state.currentScreen),
                      ),
                    ),

                    // Order
                    TheFilters(
                      label: 'Ordenar',
                      labelSize: 17,
                      icon: FontAwesomeIcons.caretDown,
                      iconSize: 26,
                      onTap: () => myModalBottom(
                        context: context,
                        state: state,
                        child: MyOrder(currentScreen: state.currentScreen),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Projects screen
                      const ListProjects(),

                      // Tasks screens
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: ListTasks(tasks: tasksData),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // EndDrawer the more options
          endDrawer: const MyEndDrawer(),

          // Button create project
          floatingActionButton: state.currentScreen == Screens.project
              ? CreateProjectButton(
                  onTap: () => context.push(AppRoutes.createProject),
                )
              : null,
        );
      },
    );
  }
}
