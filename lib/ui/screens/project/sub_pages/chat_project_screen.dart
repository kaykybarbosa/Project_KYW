import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/domain/models/message_model.dart';
import 'package:kyw_management/ui/screens/chat/widgets/chat_project/message_chat.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class ChatProjectScreen extends StatefulWidget {
  const ChatProjectScreen({super.key, required this.projectId});

  final String projectId;

  @override
  State<ChatProjectScreen> createState() => ChatProjectScreenState();
}

class ChatProjectScreenState extends State<ChatProjectScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  void _getProjectById() => context.read<ProjectBloc>().add(GetProjectById(widget.projectId));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _getProjectById();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ProjectBloc, ProjectState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: const _Leading(),
            title: _Title(projectId: widget.projectId),
            actions: const [_PopupMenuItem()],
            bottom: TabBar(
              controller: _tabController,
              labelStyle: const TextStyle(fontSize: TConstants.fontSizeMd),
              indicatorWeight: 3,
              tabs: const <Widget>[
                Tab(text: 'Chat'),
                Tab(text: 'Tarefas'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              /// Chat
              switch (state.status) {
                ProjectStatus.detailInProgress => const Center(child: CircularProgressIndicator()),
                ProjectStatus.detailFailure =>
                  const Center(child: Text('Ops... Não foi possível realizar sua solicitação.')),
                _ => _ChatProject(
                    messages: [
                      MessageModel(
                        userReference: 'Test',
                        message: state.detailProject.creator.nickname,
                        dateSend: DateFormat().add_Hm().format(DateTime.now()),
                        isSender: false,
                        nameColor: Colors.orange,
                      ),
                    ],
                  ),
              },

              /// Tasks
              _TasksProject(widget: widget),
            ],
          ),
        ),
      );
}

class _Leading extends StatelessWidget {
  const _Leading();

  @override
  Widget build(BuildContext context) => BlocBuilder<ProjectBloc, ProjectState>(
        builder: (_, state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: InkWell(
            onTap: () => Get.back(),
            borderRadius: const BorderRadius.all(Radius.elliptical(50, 50)),
            highlightColor: Colors.grey,
            splashColor: Colors.grey,
            child: Row(
              children: <Widget>[
                const Icon(Icons.arrow_back),
                state.detailProject.imageUrl == null
                    ? CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage(state.detailProject.imageUrl ?? 'assets/casa-na-arvore.webp'),
                      )
                    : const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.group),
                      )
              ],
            ),
          ),
        ),
      );
}

class _PopupMenuItem extends StatelessWidget {
  const _PopupMenuItem();

  @override
  Widget build(BuildContext context) => PopupMenuButton(
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

class _Title extends StatelessWidget {
  const _Title({required this.projectId});

  final String projectId;
  static late ProjectResponse _project;

  @override
  Widget build(BuildContext context) {
    _project = context.read<ProjectBloc>().getProjectById(projectId);

    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (_, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Project name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              _project.name,
              style: const TextStyle(
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Members the group
          const Text(
            'Você',
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}

class _Members extends StatelessWidget {
  const _Members({required this.widget});

  final ChatProjectScreen widget;

  @override
  Widget build(BuildContext context) => const SizedBox(
        width: 200,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text(
                  'Kbuloso, Marquinho...',
                  style: TextStyle(
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

class _ChatProject extends StatelessWidget {
  const _ChatProject({required this.messages});

  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /// Mensagens
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return MessageChat(message: message);
              },
            ),
          ),

          /// Enviar mensagem
          const _MessageInput(),
        ],
      );
}

class _TasksProject extends StatelessWidget {
  const _TasksProject({required this.widget});

  final ChatProjectScreen widget;

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          children: [
            Text('TASKS')
            // Input Search
            // MySearchBar(
            //   hintText: 'Buscar tarefas',
            //   search: () {},
            // ),
            // Filters bar
            // const FiltersBarTasks(),
            // All tasks
            // ListAllTaks(projectId: widget.project.id),
          ],
        ),
      );
}

class _MessageInput extends StatefulWidget {
  const _MessageInput();

  @override
  State<_MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<_MessageInput> {
  late final TextEditingController _controller;

  String? get _projectId => context.findAncestorStateOfType<ChatProjectScreenState>()?.widget.projectId;

  String? _getMessageToProject() {
    if (_projectId != null) {
      return context.read<SendMessageCubit>().getMessageToProject(_projectId!);
    }
    return null;
  }

  void _messageChanged(String value) {
    if (_projectId != null) {
      context.read<SendMessageCubit>().messageChanged(_projectId!, value);
    }
  }

  void _initController() {
    _controller = TextEditingController();

    final message = _getMessageToProject();
    if (message != null) {
      _controller.text = message;
    }
  }

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            /// Input
            Flexible(
              child: SearchBar(
                hintText: 'Mensagem',
                controller: _controller,
                onChanged: (value) => _messageChanged(value),
                side: const WidgetStatePropertyAll(BorderSide.none),
                backgroundColor: const WidgetStatePropertyAll(TColors.searchBackground),
                trailing: [
                  /// Anexo
                  _MessageIcon(
                    TIcons.attachment,
                    onTap: () {},
                  ),

                  /// Câmera
                  _MessageIcon(
                    TIcons.camera,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const Gap(10),

            /// Enviar
            const _SendMessageBtn(),
          ],
        ),
      );
}

class _MessageIcon extends StatelessWidget {
  const _MessageIcon(this.icon, {this.onTap});

  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onTap,
        constraints: const BoxConstraints(maxHeight: 45, maxWidth: 45),
        highlightColor: TColors.base300.withOpacity(.5),
        icon: Icon(
          icon,
          color: TColors.base300,
          size: TConstants.iconMd - 4,
        ),
      );
}

class _SendMessageBtn extends StatelessWidget {
  const _SendMessageBtn();

  @override
  Widget build(BuildContext context) {
    void sendMessage() {
      final projectId = context.findAncestorStateOfType<ChatProjectScreenState>()?.widget.projectId;

      if (projectId != null) {
        context.read<SendMessageCubit>().sendMessage(projectId);
      }
    }

    return InkWell(
      onTap: sendMessage,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.only(bottom: 2, right: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: TColors.primary,
        ),
        child: const Icon(
          TIcons.send,
          color: Colors.white,
          size: TConstants.iconMd - 5,
        ),
      ),
    );
  }
}
