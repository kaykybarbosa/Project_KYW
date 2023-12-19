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
import 'package:kyw_management/app/widgets/home_screen/create_project_button.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/order.dart';
import 'package:kyw_management/app/widgets/home_screen/my_icon.dart';
import 'package:kyw_management/app/widgets/home_screen/my_search_bar.dart';
import 'package:kyw_management/app/widgets/home_screen/the_filters.dart';
import 'package:kyw_management/app/widgets/list_projects.dart';
import 'package:kyw_management/app/widgets/list_tasks.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    void setCurrentScreen(int value) {
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

    return DefaultTabController(
      length: 2,
      child: BlocBuilder<HomeBloc, HomeState>(
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
                    GoRouter.of(context).push(MyRoutes.notifications);
                    context
                        .read<HomeBloc>()
                        .add(const HaveMessageHome(haveMessage: false));
                  },
                ),

                // More options Icon
                MyIcon(
                  icon: CupertinoIcons.ellipsis_vertical,
                  onTap: () => openEndDrawer(),
                  showBadge: false,
                ),
              ],

              bottom: myTabBar(
                onTap: (value) {
                  setCurrentScreen(value);
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
                  MySearchBar(search: () {}),

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
                  )
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
}
