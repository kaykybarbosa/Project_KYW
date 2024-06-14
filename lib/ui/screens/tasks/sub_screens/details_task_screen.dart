import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/env/env.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/cubits/task_cubit/task_cubit.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/my_expansion_child.dart';
import 'package:kyw_management/ui/widgets/my_card_status.dart';
import 'package:kyw_management/ui/widgets/skelton_indicator.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class DetailsTaskScreen extends StatefulWidget {
  const DetailsTaskScreen({super.key, required this.taskId});

  final String taskId;

  @override
  State<DetailsTaskScreen> createState() => _DetailsTaskScreenState();
}

class _DetailsTaskScreenState extends State<DetailsTaskScreen> {
  void _getTaskById(String taskId) => context.read<TaskCubit>().getTaskById(taskId);

  @override
  void initState() {
    super.initState();

    _getTaskById(widget.taskId);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: state.status.isInProgress
                ? const SkeltonIndicator(
                    width: 120,
                    height: 20,
                  )
                : Text(
                    state.taskDetails.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
            actions: <Widget>[
              IconButton(
                tooltip: 'Editar',
                onPressed: () {},
                icon: const Icon(
                  TIcons.edit,
                  size: TConstants.iconSm + 4,
                ),
              ),
            ],
          ),
          body: switch (state.status) {
            TaskCubitStatus.inProgress => const _TaskDetailsInProgress(),
            _ => const _Body(),
          },
          floatingActionButton: state.status.isInProgress
              ? const SkeltonIndicator(width: 55, height: 55)
              : FloatingActionButton(
                  backgroundColor: TColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: const Icon(TIcons.message),
                  onPressed: () {},
                ),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const _ProjectDetails(),

                const Gap(20),

                /// Categoria
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Categoria',
                      style: TextStyle(fontSize: TConstants.fontSizeMd),
                    ),

                    /// -- Status
                    MyCardStatus(status: state.taskDetails.status),
                  ],
                ),

                const Gap(20),

                /// Descrição
                const _Description(),

                const Gap(20),

                /// -- Membros
                const _Members(),
              ],
            ),
          ),
        ),
      );
}

class _ProjectDetails extends StatelessWidget {
  const _ProjectDetails();

  @override
  Widget build(BuildContext context) {
    final project = context.select((ProjectBloc bloc) => bloc.state.projectDetails);

    return BlocBuilder<TaskCubit, TaskState>(
      buildWhen: (previous, current) => previous.taskDetails != current.taskDetails,
      builder: (context, state) {
        final task = state.taskDetails;

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Gap(10),

              /// -- Data da criação
              Text(
                task.createAtWithOptions,
                style: const TextStyle(color: TColors.base200),
              ),

              /// -- Detalhes
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.base200),
                  borderRadius: const BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: _Card(
                        title: 'Admin',
                        info: project.creator.nickname,
                      ),
                    ),
                    Flexible(
                      child: _Card(
                        title: 'Projeto',
                        info: project.name,
                        isRight: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) => BlocBuilder<TaskCubit, TaskState>(
        buildWhen: (previous, current) => previous.taskDetails != current.taskDetails,
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Descrição',
              style: TextStyle(
                color: TColors.base200,
                fontSize: TConstants.fontSizeMd,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3, top: 5, right: 5),
              child: Text(
                '${state.taskDetails.description}',
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: TConstants.fontSizeMd + 1,
                ),
              ),
            )
          ],
        ),
      );
}

class _Members extends StatefulWidget {
  const _Members();

  @override
  State<_Members> createState() => _MembersState();
}

class _MembersState extends State<_Members> {
  bool _isExpanded = false;

  void _changedExpansion(bool value) => setState(() => _isExpanded = value);

  Widget _buildAvatarUrl(String? avatarUrl) {
    const imageCircular = TConstants.imageCircular;

    if (avatarUrl != null) {
      final image = avatarUrl.replaceAll(RegExp(r'localhost'), Env.LOCALHOST);

      return Container(
        color: TColors.base120,
        width: imageCircular,
        height: imageCircular,
        child: Image.network(
          image,
          width: imageCircular,
          height: imageCircular,
          cacheWidth: 123,
          cacheHeight: 123,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        color: TColors.base200,
        width: TConstants.imageCircular,
        height: TConstants.imageCircular,
        child: const Icon(
          TIcons.solidUser,
          color: TColors.base100,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TaskCubit, TaskState>(
        buildWhen: (previous, current) => previous.taskDetails != current.taskDetails,
        builder: (context, state) {
          // final members = context.select((ProjectBloc bloc) => bloc.state.members);
          final members = state.taskDetails.attributedTo;

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
              border: Border.all(color: TColors.borderSideColor),
            ),
            child: ExpansionTile(
              onExpansionChanged: _changedExpansion,
              initiallyExpanded: true,
              trailing: AnimatedRotation(
                turns: _isExpanded ? 0 : .5,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  TIcons.arrowTop,
                  color: TColors.primary,
                ),
              ),
              backgroundColor: TColors.base200.withOpacity(.30),
              collapsedBackgroundColor: TColors.base200.withOpacity(.30),
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
              ),
              title: const Text(
                'Membros',
                style: TextStyle(
                  color: TColors.expansionTileTextColor,
                  fontSize: TConstants.fontSizeMd,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: List.generate(
                members.length,
                (index) {
                  final member = members[index];
                  final isFirst = members.first == member;
                  final isLast = members.last == member;

                  return MyExpansionChild(
                    isFirst: isFirst,
                    isLast: isLast,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: _buildAvatarUrl(member.avatarUrl),
                      ),
                      title: Text(
                        member.isCurrentUser ? 'Você' : member.nickname,
                        style: const TextStyle(
                          fontSize: TConstants.fontSizeMd,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.info,
    this.isRight = false,
  });

  final String title;
  final String info;
  final bool isRight;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: TColors.primary,
          border: Border(
            left: isRight ? const BorderSide(color: TColors.base200, width: .5) : BorderSide.none,
            right: isRight ? BorderSide.none : const BorderSide(color: TColors.base200, width: .5),
          ),
          borderRadius: BorderRadius.horizontal(
            left: isRight ? Radius.zero : const Radius.circular(TConstants.cardRadiusXs),
            right: isRight ? const Radius.circular(TConstants.cardRadiusXs) : Radius.zero,
          ),
        ),
        child: Column(
          children: <Widget>[
            _TitleChild(label: title),
            _InfoChild(
              info: info,
              isRight: isRight,
            ),
          ],
        ),
      );
}

class _TitleChild extends StatelessWidget {
  const _TitleChild({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(maxWidth: Get.width * .6),
        color: TColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Text(
          label,
          style: const TextStyle(
            color: TColors.base100,
            fontSize: TConstants.fontSizeLg,
          ),
        ),
      );
}

class _InfoChild extends StatelessWidget {
  const _InfoChild({required this.info, this.isRight = false});

  final String info;
  final bool isRight;

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(maxWidth: Get.width * .6),
        decoration: BoxDecoration(
          color: TColors.base100,
          borderRadius: BorderRadius.only(
            bottomLeft: isRight ? Radius.zero : const Radius.circular(TConstants.cardRadiusXs),
            bottomRight: isRight ? const Radius.circular(TConstants.cardRadiusXs) : Radius.zero,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                info,
                style: const TextStyle(fontSize: TConstants.fontSizeLg),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}

class _TaskDetailsInProgress extends StatelessWidget {
  const _TaskDetailsInProgress();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(TConstants.defaultMargin),
        child: Column(
          children: <Widget>[
            /// Detalhes
            SkeltonIndicator(height: 120),

            /// Categoria / Status
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SkeltonIndicator(width: 100, height: 25),
                  SkeltonIndicator(width: 100, height: 25),
                ],
              ),
            ),

            /// Descrição
            SkeltonIndicator(
              height: 100,
            ),

            Gap(20),

            /// Membros
            SkeltonIndicator(height: 50)
          ],
        ),
      );
}
