import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyw_management/app/models/message_model.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/screens/chat/add_task_screen.dart';
import 'package:kyw_management/app/widgets/card_task.dart';
import 'package:kyw_management/app/widgets/home_screen/my_search_bar.dart';
import 'package:kyw_management/app/widgets/home_screen/the_filters.dart';
import 'package:kyw_management/domain/services/routers/export_routes.dart';

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
        actions: [
          PopupMenuButton(
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
          ),
        ],
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
          Padding(
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TheFilters(
                      onTap: () {},
                      label: 'Filtrar',
                      labelSize: 17,
                      iconSize: 17,
                      icon: FontAwesomeIcons.filter,
                    ),
                    Chip(
                      label: const Text('Mostrar todos'),
                      labelStyle: TextStyle(color: Colors.blue[700]),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    TheFilters(
                      onTap: () {},
                      label: 'Ordenar',
                      labelSize: 17,
                      iconSize: 25,
                      icon: FontAwesomeIcons.caretDown,
                    ),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      // List tasks
                      widget.project.tasks != null
                          ? ListView.builder(
                              itemCount: widget.project.tasks!.length,
                              itemBuilder: (context, index) {
                                List<Task> tasks = widget.project.tasks!;
                                return CardTask(task: tasks[index]);
                              },
                            )
                          : Center(
                              child: Text(
                                'Sem tarefas ainda!',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 20,
                                ),
                              ),
                            ),
                      // Add task button
                      Positioned(
                        right: 0,
                        bottom: 8,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                              onPressed: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => const AddTaskScreen(),
                              ),
                              backgroundColor: Colors.blue[700],
                              child: const Icon(
                                Icons.add,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
              return _Message(message: message);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              _MessageInput(),
              _ButtonSend(),
            ],
          ),
        ),
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: message.isSender ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        right: message.isSender ? 8 : 75,
        left: message.isSender ? 75 : 8,
        top: 5,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 7,
          bottom: 7,
          left: message.isSender ? 10 : 15,
          right: message.isSender ? 15 : 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[350],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
            topLeft: message.isSender ? const Radius.circular(10) : Radius.zero,
            topRight: message.isSender ? Radius.zero : const Radius.circular(10),
            bottomLeft: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User name
            Visibility(
              visible: !message.isSender,
              child: Text(
                message.userReference,
                style: TextStyle(
                  color: message.nameColor,
                  fontSize: 17,
                ),
              ),
            ),
            // Message send
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '${message.message}           ',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    message.dateSend,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SearchBar(
        backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
        hintText: 'Mensagem',
        trailing: [
          Transform.rotate(
            angle: 0.5,
            child: const Icon(Icons.attach_file_rounded),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 5),
            child: Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}

class _ButtonSend extends StatelessWidget {
  const _ButtonSend();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blue[700],
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.send_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
