import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
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
    ),
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
      status: Status.completo,
    ),
    Task(
      title: 'Revisão do Projeto',
      description: 'Verificar e ajustar caso precise',
      status: Status.pendente,
    ),
  ];

  Color itemsBarColor = CupertinoColors.lightBackgroundGray;
  BoxDecoration _decoration = MyDecorations.inputDecoration(borderRadius: 20.0);

  Screens _currentText = Screens.project;
  bool _haveMessage = true;
  bool _showFilterBar = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      // Add Listerner the Scroll
      // _scrollController.addListener(() => _scrollDirection());
    });
  }

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

  void _setDecoration({double borderRadius = 20.0, bool isActive = true}) {
    setState(() {
      _decoration = MyDecorations.inputDecoration(
        borderRadius: borderRadius,
        isActice: isActive,
      );
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
              // FiltersBar
              Expanded(
                flex: _showFilterBar ? 2 : 0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Input Search
                        Visibility(
                          visible: _showFilterBar,
                          child: Expanded(
                            flex: _showFilterBar ? 1 : 0,
                            child: CupertinoTextField(
                              placeholder: _currentText == Screens.project
                                  ? 'Buscar projeto'
                                  : 'Buscar tarefa',
                              decoration: _decoration,
                              style:
                                  MyDecorations.inputTextStyle(fontSize: 19.0),
                              onTap: () {
                                _setDecoration(isActive: true);
                              },
                              onEditingComplete: () {
                                _setDecoration(isActive: false);
                              },
                            ),
                          ),
                        ),

                        // Icon Search
                        Visibility(
                          visible: _showFilterBar,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            height: 38.0,
                            width: 38.0,
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemBlue,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.search,
                                size: 23.0,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Buttons the filters
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Filter
                        _filterButton(
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
                        _filterButton(
                          onTap: () {},
                          label: 'Ordenar',
                          icon: CupertinoIcons.chevron_down,
                          size: 23.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Current screen
              Expanded(
                flex: 12,
                child: _currentText == Screens.project
                    ? ListProjects(
                        projects: _projects,
                        showFilterBar: (isVisible) {
                          _setShowFilterBar(isVisible: isVisible);
                        },
                      )
                    : ListTasks(tasks: _tasks),
              ),
            ],
          ),
        ),

        // Button add project
        floatingActionButton: _currentText == Screens.project
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _projects.add(
                        Project(
                          name: 'Casa na Árvore',
                          image: 'assets/casa-na-arvore.webp',
                          lastMessage: 'última mensagem envia...',
                          lastMessageTime: '12:25',
                          isImportant: true,
                        ),
                      );
                    });
                  },
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
                        _haveMessage = false;
                      });
                    },
                    child: Badge(
                      label: _haveMessage ? const Text('2') : null,
                      smallSize: _haveMessage ? 6 : 0,
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

  GestureDetector _filterButton({
    required Function onTap,
    required String label,
    required IconData icon,
    double? size,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: CupertinoColors.systemGrey2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
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
