import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/enums/filters_enum.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/enums/screens.dart';
import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/widgets/filter.dart';
import 'package:kyw_management/app/widgets/list_projects.dart';
import 'package:kyw_management/app/widgets/list_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Project> _projects = [
    Project(
      name: 'Casa na Árvore',
      image: 'assets/casa-na-arvore.webp',
      lastMessage: 'última mensagem envia...',
      lastMessageTime: '12:25',
      isImportant: true,
    ),
    Project(
      name: 'Projeto do Milhão',
      lastMessage: 'última mensagem envia...',
      lastMessageTime: '14:32',
    )
  ];

  final List<Task> _tasks = [
    Task(
      title: 'Apresentar Projeto',
      description:
          'Descrição da tarefa pode ficar grande a dessds dsd sd scricao',
      isImportant: true,
    ),
    Task(
      title: 'Fazer Orçamento',
      description: 'Buscar os melhores valores dos materiais',
      status: Status.complete,
    ),
    Task(
      title: 'Revisão do Projeto',
      description: 'Verificar e ajustar caso precise',
      status: Status.pending,
    ),
  ];

  Color itemsBarColor = CupertinoColors.lightBackgroundGray;
  BoxDecoration _decoration = MyDecorations.inputDecoration(borderRadius: 20.0);

  Widget? _currentScreen;
  Screens _currentText = Screens.project;
  bool _haveMessage = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentScreen = ListProjects(projects: _projects);
    });
  }

  _setCurrentScreen(int value) {
    /// [value] == 0 => ShowMyProjects and
    /// [value] == 1 => ShowMyTasks

    setState(() {
      if (value == 0) {
        _currentText = Screens.project;
        _currentScreen = ListProjects(
          projects: _projects,
        );
      } else {
        _currentText = Screens.task;
        _currentScreen = ListTasks(tasks: _tasks);
      }
    });
  }

  _setDecoration({double borderRadius = 20.0, bool isActive = true}) {
    setState(() {
      _decoration = MyDecorations.inputDecoration(
        borderRadius: borderRadius,
        isActice: isActive,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myAppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 15.0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Input Search
                  Expanded(
                    child: CupertinoTextField(
                      placeholder: _currentText == Screens.project
                          ? 'Buscar projeto'
                          : 'Buscar tarefa',
                      decoration: _decoration,
                      style: MyDecorations.inputTextStyle(fontSize: 19.0),
                      onTap: () {
                        _setDecoration(isActive: true);
                      },
                      onEditingComplete: () {
                        _setDecoration(isActive: false);
                      },
                    ),
                  ),

                  // Icon Search
                  Container(
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.only(left: 10.0),
                    height: 38.0,
                    width: 38.0,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBlue,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.search,
                        size: 23.0,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15.0),

              // Buttons the filters
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Filter
                  filterButton(
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
                    icon: Icons.filter_list_alt,
                  ),

                  // Order
                  filterButton(
                    onTap: () {},
                    label: 'Ordenar',
                    icon: CupertinoIcons.chevron_down,
                    size: 23.0,
                  ),
                ],
              ),

              const SizedBox(height: 18.0),

              // Current screen
              Expanded(child: _currentScreen!)
            ],
          ),
        ),

        // Button add project
        floatingActionButton: _currentText == Screens.project
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: CupertinoColors.activeBlue,
                  child: const Icon(
                    CupertinoIcons.add,
                    size: 30.0,
                    color: CupertinoColors.white,
                  ),
                ),
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
                  GestureDetector(
                    onTap: () {
                      context.push(MyRoutes.notifications);
                      setState(() {
                        _haveMessage = true;
                      });
                    },
                    child: Badge(
                      label: _haveMessage ? null : const Text('2'),
                      smallSize: _haveMessage ? 0 : 6,
                      child: myIcon(CupertinoIcons.bell),
                    ),
                  ),

                  const SizedBox(width: 15.0),

                  // More options
                  GestureDetector(
                      child: myIcon(CupertinoIcons.ellipsis_vertical)),
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
        labelStyle: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 18.0,
        ),
        onTap: (value) {
          _setCurrentScreen(value);
        },
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

  Icon myIcon(IconData icon) {
    return Icon(
      icon,
      color: itemsBarColor,
      size: 22.0,
    );
  }

  GestureDetector filterButton(
      {required Function onTap, String? label, IconData? icon, double? size}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: CupertinoColors.systemGrey2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label ?? '',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 5.0),
            Icon(
              icon,
              color: CupertinoColors.systemGrey2,
              size: size,
            ),
          ],
        ),
      ),
    );
  }
}
