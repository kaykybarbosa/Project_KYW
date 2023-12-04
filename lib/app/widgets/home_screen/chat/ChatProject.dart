import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/models/chat.dart';
import 'package:kyw_management/app/widgets/home_screen/app_bar/my_tab_bar.dart';

class ChatProject extends StatefulWidget {
  const ChatProject({super.key, required this.chat});

  final Chat chat;

  @override
  State<ChatProject> createState() => _ChatProjectState();
}

class _ChatProjectState extends State<ChatProject> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CupertinoTheme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: CupertinoColors.white,
            ),
            onPressed: () {},
          ),
          title: Text(''),
          bottom: myTabBar(
            onTap: () {},
            tabs: const [
              Tab(text: 'Chat'),
              Tab(text: 'Tarefas'),
            ],
          ),
        ),
        body: Text('data'),
      ),
    );
  }
}
