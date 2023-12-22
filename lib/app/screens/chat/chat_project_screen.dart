import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kyw_management/app/models/message_model.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/widgets/home_screen/my_search_bar.dart';
import 'package:kyw_management/domain/services/routers/export_routes.dart';

import 'widgets/chat_project/button_send_chat.dart';
import 'widgets/chat_project/message_chat.dart';
import 'widgets/chat_project/message_input_chat.dart';
import 'widgets/tasks_project/filters_bar_tasks.dart';
import 'widgets/tasks_project/list_all_tasks.dart';

class ChatProjectScreen extends StatefulWidget {
  const ChatProjectScreen({super.key, required this.project});

  final Project project;

  @override
  State<ChatProjectScreen> createState() => _ChatProjectScreenState();
}

class _ChatProjectScreenState extends State<ChatProjectScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  List<MessageModel> messages = [
    MessageModel(
      userReference: 'Yuri',
      message: 'Bom dia pessoal',
      dateSend: DateFormat().add_Hm().format(DateTime.now()),
      isSender: false,
      nameColor: Colors.orange,
    ),
    MessageModel(
      userReference: 'Kayky',
      message: 'Go vava',
      dateSend: DateFormat().add_Hm().format(DateTime.now()),
      isSender: true,
      nameColor: Colors.black,
    ),
    MessageModel(
      userReference: 'Wesly',
      message: 'I love java',
      dateSend: DateFormat().add_Hm().format(DateTime.now()),
      isSender: false,
      nameColor: Colors.blue,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoTheme.of(context).primaryColor,
        leading: _Leading(widget: widget),
        title: _Title(widget: widget),
        actions: const [_PopupMenuItem()],
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontSize: 18),
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Chat'),
            Tab(text: 'Tarefas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Chat screen
          _ChatProject(messages: messages),
          // Tasks screen
          _TasksProject(widget: widget),
        ],
      ),
    );
  }
}

class _PopupMenuItem extends StatelessWidget {
  const _PopupMenuItem();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      offset: const Offset(0, 95),
      elevation: 9,
      itemBuilder: (context) => [
        const PopupMenuItem(
          child: ListTile(title: Text('Projeto info')),
        ),
        const PopupMenuItem(
          child: ListTile(title: Text('Limpar mensagens')),
        ),
        const PopupMenuItem(
          child: ListTile(title: Text('Sair do projeto')),
        )
      ],
    );
  }
}

class _TasksProject extends StatelessWidget {
  const _TasksProject({required this.widget});

  final ChatProjectScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        children: [
          // Input Search
          MySearchBar(
            hintText: 'Buscar tarefas',
            search: () {},
          ),
          // Filters bar
          const FiltersBarTasks(),
          // All tasks
          ListAllTaks(projectId: widget.project.id),
        ],
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading({required this.widget});

  final ChatProjectScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => context.pop(context),
        borderRadius: const BorderRadius.all(Radius.elliptical(50, 50)),
        highlightColor: Colors.grey,
        splashColor: Colors.grey,
        child: Row(
          children: [
            const Icon(Icons.arrow_back),
            widget.project.image != null
                ? CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(widget.project.image!),
                  )
                : const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.group),
                  )
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.widget});

  final ChatProjectScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project name
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            widget.project.name,
            style: const TextStyle(
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // Members the group
        widget.project.users != null
            ? _Members(widget: widget)
            : const Text(
                'Você',
                style: TextStyle(fontSize: 12),
              )
      ],
    );
  }
}

class _Members extends StatelessWidget {
  const _Members({required this.widget});

  final ChatProjectScreen widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                widget.project.usersToString(),
                style: const TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatProject extends StatelessWidget {
  const _ChatProject({required this.messages});

  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];
              return MessageChat(message: message);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              MessageInputChat(),
              ButtonSendChat(),
            ],
          ),
        ),
      ],
    );
  }
}
