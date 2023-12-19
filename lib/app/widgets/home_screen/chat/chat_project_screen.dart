import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/domain/services/routers/export_routes.dart';

class ChatProjectScreen extends StatefulWidget {
  const ChatProjectScreen({super.key, required this.project});

  final Project project;

  @override
  State<ChatProjectScreen> createState() => _ChatProjectScreenState();
}

class _ChatProjectScreenState extends State<ChatProjectScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CupertinoTheme.of(context).primaryColor,
          leading: _Leading(widget: widget),
          title: _Title(widget: widget),
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
          children: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text('Hoje')),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [_MessageInput(), _ButtonSend()],
                  ),
                ),
              ],
            ),
            Text('Tasks')
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blue[700],
      ),
      child: IconButton(
        onPressed: () {},
        icon: Transform.rotate(
          angle: -0.9,
          child: const Icon(
            Icons.send_rounded,
            color: Colors.white,
          ),
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            widget.project.name,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        widget.project.users != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.project.users!.map((e) {
                  return Text(
                    '${e.name}, ',
                    style: const TextStyle(fontSize: 15),
                  );
                }).toList(),
              )
            : const Text(
                'Você',
                style: TextStyle(fontSize: 15),
              )
      ],
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
