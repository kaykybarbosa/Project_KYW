import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/data/tasks.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/enums/screens.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/app_name.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/end_drawer.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/my_tab_bar.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/my_filter.dart';
import 'package:kyw_management/app/widgets/home_screen/create_project_button.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/order.dart';
import 'package:kyw_management/app/widgets/home_screen/my_icon.dart';
import 'package:kyw_management/app/widgets/home_screen/my_search_bar.dart';
import 'package:kyw_management/app/widgets/home_screen/the_filters.dart';
import 'package:kyw_management/app/widgets/list_projects.dart';
import 'package:kyw_management/app/widgets/list_tasks.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _setCurrentScreen(int value) {
    /// [value] == 0 => ShowMyProjects and
    /// [value] == 1 => ShowMyTasks

    if (value == 0) {
      context
          .read<HomeBloc>()
          .add(const ScreenChangedHome(screen: Screens.project));
    } else {
      context
          .read<HomeBloc>()
          .add(const ScreenChangedHome(screen: Screens.task));
    }
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              // App name
              leading: AppName(color: Theme.of(context).colorScheme.onPrimary),
              actions: [
                // Messages Icon
                MyIcon(
                  icon: CupertinoIcons.bell,
                  onTap: () {
                    GoRouter.of(context).push(MyRoutes.notifications);
                    context
                        .read<HomeBloc>()
                        .add(const HaveMessageHome(haveMessage: false));
                  },
                ),

                // More options Icon
                MyIcon(
                  icon: CupertinoIcons.ellipsis_vertical,
                  onTap: () => _openEndDrawer(),
                  showBadge: false,
                ),
              ],

              toolbarHeight: 50,
              bottom: myTabBar(
                onTap: (value) {
                  _setCurrentScreen(value);
                },
                tabs: const [
                  Tab(text: 'Projetos'),
                  Tab(text: 'Tarefas'),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 15,
              ),
              child: Column(
                children: [
                  // Input Search
                  const MySearchBar(),

                  // Buttons the filters
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Filter
                      TheFilters(
                        label: 'Filtrar',
                        labelSize: 17,
                        iconSize: 17,
                        icon: FontAwesomeIcons.filter,
                        onTap: () => _showModalFilter(context, state),
                      ),

                      // Order
                      TheFilters(
                        label: 'Ordenar',
                        labelSize: 17,
                        icon: FontAwesomeIcons.caretDown,
                        iconSize: 26,
                        onTap: () => _showModalOrder(context, state),
                      ),
                    ],
                  ),

                  // Current screen
                  Expanded(
                    flex: 12,
                    child: state.currentScreen == Screens.project
                        ? const ListProjects()
                        : ListTasks(tasks: tasksData),
                  ),
                ],
              ),
            ),

            // EndDrawer the more options
            endDrawer: const MyEndDrawer(),

            // Button create project
            floatingActionButton: state.currentScreen == Screens.project
                ? CreateProjectButton(
                    onTap: () {
                      context.push(MyRoutes.createProject);
                    },
                  )
                : null,
          );
        },
      ),
    );
  }

  Future<dynamic> _showModalFilter(
    BuildContext context,
    HomeState state,
  ) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: 700,
        child: MyFilter(currentScreen: state.currentScreen),
      ),
    );

    resetBlocCurrentScreen();
  }

  void resetBlocCurrentScreen() {
    context
        .read<FilterProjectBloc>()
        .add(const ResetFilterProject(resetDates: true));
  }

  Future<dynamic> _showModalOrder(BuildContext context, HomeState state) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: 700,
        child: Order(currentScreen: state.currentScreen),
      ),
    );
  }
}
