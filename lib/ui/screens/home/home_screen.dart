import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/screens/home/widgets/drawer/my_end_drawer.dart';
import 'package:kyw_management/ui/screens/home/widgets/home_appbar.dart';
import 'package:kyw_management/ui/screens/project/project_screen.dart';
import 'package:kyw_management/ui/screens/tasks/task_screen.dart';
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
    tabController.addListener(() => _setCurrentScreen());
  }

  void _setCurrentScreen() {
    /// [value] == 0 => ShowMyProjects and
    /// [value] == 1 => ShowMyTasks

    final homeContext = context.read<HomeBloc>();

    if (tabController.index == 0) {
      homeContext.add(const ScreenChanged(screen: Screens.project));
    } else {
      homeContext.add(const ScreenChanged(screen: Screens.task));
    }
  }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => Scaffold(
          key: scaffoldKey,
          endDrawer: const MyEndDrawer(),
          body: NestedScrollView(
            floatHeaderSlivers: true,
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (_, __) => [
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
                      ProjectScreen(),

                      /// -- Tasks
                      TaskScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
