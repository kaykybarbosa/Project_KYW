import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/data/dtos/response/message_response.dart';
import 'package:kyw_management/ui/screens/project/sub_screens/tasks_project_screen.dart';
import 'package:kyw_management/ui/screens/project/widgets/message_chat.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:kyw_management/ui/state_management/cubits/task_cubit/task_cubit.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class ChatProjectScreen extends StatefulWidget {
  const ChatProjectScreen({super.key, required this.projectId});

  final String projectId;

  @override
  State<ChatProjectScreen> createState() => ChatProjectScreenState();
}

class ChatProjectScreenState extends State<ChatProjectScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => BlocConsumer<ProjectBloc, ProjectState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isDetailSuccess) {
            context.read<TaskCubit>().getAllTasks();
          }
        },
        builder: (context, state) => _Body(widget.projectId),
      );
}

class _Body extends StatefulWidget {
  const _Body(this.projectId);

  final String projectId;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  void _getProjectById() => context.read<ProjectBloc>().add(GetProjectById(widget.projectId));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _getProjectById();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ProjectBloc, ProjectState>(
        buildWhen: (previous, current) =>
            previous.status != current.status || previous.messages.length != current.messages.length,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: const _Leading(),
            leadingWidth: 65,
            title: _Title(projectId: widget.projectId),
            actions: const [_PopupMenuItem()],
            bottom: TabBar(
              controller: _tabController,
              labelStyle: const TextStyle(fontSize: TConstants.fontSizeMd),
              indicatorWeight: 3,
              tabs: const <Widget>[
                Tab(text: 'Chat'),
                Tab(text: 'Tasks'),
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
                _ => _ChatProject(messages: state.messages),
              },

              /// Tasks
              TasksProjectScreen(projectId: widget.projectId),
            ],
          ),
        ),
      );
}

class _Leading extends StatelessWidget {
  const _Leading();

  @override
  Widget build(BuildContext context) => BlocBuilder<ProjectBloc, ProjectState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (_, state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: InkWell(
            onTap: () => Get.back(),
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.elliptical(50, 50)),
            child: Row(
              children: <Widget>[
                const Icon(Icons.arrow_back),
                state.detailProject.imageUrl != null
                    ? Hero(
                        tag: 'details_project',
                        child: Container(
                          width: TConstants.imageCircular - 5,
                          decoration: BoxDecoration(
                            color: TColors.base150,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                state.detailProject.imageUrlLocal!,
                                maxWidth: 157,
                                maxHeight: 217,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Hero(
                        tag: 'details_project',
                        child: Container(
                          width: TConstants.imageCircular - 5,
                          decoration: const BoxDecoration(
                            color: TColors.base200,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/group.png',
                            width: TConstants.imageCircular - 5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
}

class _PopupMenuItem extends StatelessWidget {
  const _PopupMenuItem();

  @override
  Widget build(BuildContext context) {
    void deleteMessages() {
      final projectId = context.findAncestorStateOfType<ChatProjectScreenState>()?.widget.projectId;

      if (projectId != null) {
        context.read<ProjectBloc>().add(DeleteMessages(projectId));
      }
    }

    final List<Map<String, dynamic>> options = [
      {
        'label': 'Limpar mensagens',
        'onTap': () => {
              deleteMessages(),
              Get.back(),
            },
      },
      {
        'label': 'Sair do projeto',
        'onTap': () {},
      },
    ];

    return PopupMenuButton(
      icon: const Icon(
        TIcons.more,
        size: TConstants.iconMd - 4,
      ),
      offset: const Offset(0, 95),
      elevation: 9,
      itemBuilder: (_) => options
          .map(
            (value) => PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  value['label'],
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                onTap: value['onTap'],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.projectId});

  final String projectId;
  static late ProjectResponse _project;

  @override
  Widget build(BuildContext context) {
    _project = context.read<ProjectBloc>().getProjectById(projectId);

    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (_, state) => GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.detailsProject),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Nome
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

            /// Membros
            const Text(
              'Você',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
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

class _ChatProject extends StatefulWidget {
  const _ChatProject({required this.messages});

  final List<MessageResponse> messages;

  @override
  State<_ChatProject> createState() => _ChatProjectState();
}

class _ChatProjectState extends State<_ChatProject> {
  late final ScrollController _controller;

  void _scrollToEnd() {
    Future.delayed(Duration.zero, () {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(microseconds: 1),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();

    _scrollToEnd();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if (state.status.isNewMessage) {
            _scrollToEnd();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /// Mensagens
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  controller: _controller,
                  itemCount: widget.messages.length,
                  itemBuilder: (_, index) {
                    final message = widget.messages[index];

                    final hasNip = (index == 0) ||
                        (index == widget.messages.length - 1 &&
                            message.sender.userId != widget.messages[index - 1].sender.userId) ||
                        (message.sender.userId != widget.messages[index - 1].sender.userId &&
                            message.sender.userId == widget.messages[index + 1].sender.userId) ||
                        (message.sender.userId != widget.messages[index - 1].sender.userId &&
                            message.sender.userId != widget.messages[index + 1].sender.userId);

                    return MessageChat(message: message, hasNip: hasNip);
                  },
                ),
              ),
            ),

            /// Enviar mensagem
            const _MessageInput(),
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

  void _sendMessage() {
    if (_projectId != null) {
      context.read<SendMessageCubit>().sendMessage(_projectId!);
      _controller.text = '';
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
        padding: const EdgeInsets.only(
          left: 3,
          top: 3,
          right: 3,
          bottom: 6,
        ),
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
            _SendMessageBtn(_sendMessage),
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
  const _SendMessageBtn(this.onSendMessage);

  final Function()? onSendMessage;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onSendMessage,
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
