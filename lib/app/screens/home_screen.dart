import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/data/projects.dart';
import 'package:kyw_management/app/data/tasks.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/enums/screens.dart';
import 'package:kyw_management/app/widgets/filter.dart';
import 'package:kyw_management/app/widgets/home_screen/create_project_button.dart';
import 'package:kyw_management/app/widgets/home_screen/my_icon.dart';
import 'package:kyw_management/app/widgets/home_screen/my_search_bar.dart';
import 'package:kyw_management/app/widgets/home_screen/the_filters.dart';
import 'package:kyw_management/app/widgets/list_projects.dart';
import 'package:kyw_management/app/widgets/list_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color itemsBarColor = CupertinoColors.lightBackgroundGray;
  Screens _currentText = Screens.project;
  bool _haveMessage = true;
  bool _showFilterBar = true;

  // Functions
  void _setCurrentScreen(int value) {
    /// [value] == 0 => ShowMyProjects and
    /// [value] == 1 => ShowMyTasks

    setState(() {
      if (value == 0) {
        _currentText = Screens.project;
      } else {
        _currentText = Screens.task;
      }
    });
  }

  void _setShowFilterBar({required bool isVisible}) {
    setState(() {
      _showFilterBar = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 15.0,
          ),
          child: Column(
            children: [
              // Input Search
              Visibility(
                visible: _showFilterBar,
                child: MySearchBar(
                    placeHolder:
                        _currentText == Screens.project ? 'projeto' : 'task'),
              ),

              // Buttons the filters
              Visibility(
                visible: _showFilterBar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Filter
                    TheFilters(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Filter(currentScreen: _currentText);
                          },
                        );
                      },
                      label: 'Filtrar',
                      labelSize: 17.0,
                      icon: FontAwesomeIcons.filter,
                      iconSize: 17.0,
                    ),

                    // Order
                    TheFilters(
                      onTap: () {},
                      label: 'Ordenar',
                      labelSize: 17.0,
                      icon: FontAwesomeIcons.caretDown,
                      iconSize: 26.0,
                    ),
                  ],
                ),
              ),

              // Current screen
              Expanded(
                flex: 12,
                child: _currentText == Screens.project
                    ? ListProjects(
                        projects: projectsData,
                        showFilterBar: (isVisible) {
                          _setShowFilterBar(isVisible: isVisible);
                        },
                      )
                    : ListTasks(tasks: tasksData),
              )
            ],
          ),
        ),

        // Button create project
        floatingActionButton: _currentText == Screens.project
            ? CreateProjectButton(
                onTap: () {
                  context.push(MyRoutes.createProject);
                },
              )
            : null,
      ),
    );
  }

  PreferredSizeWidget myAppBar() {
    return AppBar(
      title: Column(
        children: [
          const SizedBox(height: 10.0),
          // App name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'KYW',
                style: TextStyle(
                  color: itemsBarColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Right icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Notifications
                  Badge(
                    label: _haveMessage ? const Text('2') : null,
                    smallSize: _haveMessage ? 6 : 0,
                    child: MyIcon(
                      icon: CupertinoIcons.bell,
                      color: itemsBarColor,
                      onTap: () {
                        context.push(MyRoutes.notifications);
                        setState(() {
                          _haveMessage = false;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 15.0),

                  // More options
                  MyIcon(
                    icon: CupertinoIcons.ellipsis_vertical,
                    color: itemsBarColor,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      elevation: 0,
      toolbarHeight: 50.0,
      backgroundColor: CupertinoTheme.of(context).primaryColor,
      bottom: TabBar(
        tabs: const [
          Tab(text: 'Projetos'),
          Tab(text: 'Tarefas'),
        ],
        onTap: (value) {
          _setCurrentScreen(value);
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
      ),
    );
  }
}
