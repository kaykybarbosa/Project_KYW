import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/screens/tasks/widgets/filters_bar_tasks.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';
import 'package:kyw_management/ui/widgets/my_search_bar.dart';
import 'package:kyw_management/ui/widgets/skelton_indicator.dart';
import 'package:kyw_management/ui/widgets/tasks_in_progress.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class TasksProjectScreen extends StatelessWidget {
  const TasksProjectScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) => BlocConsumer<ProjectBloc, ProjectState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          body: const _Body(),
          floatingActionButton: state.status.isTaskInProgress
              ? const SkeltonIndicator(
                  width: 55,
                  height: 55,
                )
              : FloatingActionButton(
                  tooltip: 'Criar task',
                  backgroundColor: TColors.primary,
                  child: const Icon(TIcons.add),
                  onPressed: () => Get.toNamed(
                    AppRoutes.createTask,
                    parameters: {'id': projectId},
                  ),
                ),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(
              // horizontal: 15,
              // vertical: 10
              ),
          child: switch (state.status) {
            ProjectStatus.taskInProgress => const TasksInProgress(),
            _ => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  state.tasks.isNotEmpty
                      ? const Expanded(
                          child: CustomScrollView(
                            slivers: <Widget>[
                              /// Header
                              _HeaderTasks(),

                              /// Tarefas
                              _Tasks()
                            ],
                          ),
                        )
                      : const _TasksEmpty(),
                ],
              ),
          },
        ),
      );
}

class _HeaderTasks extends StatelessWidget {
  const _HeaderTasks();

  @override
  Widget build(BuildContext context) => SliverAppBar(
        leadingWidth: 0,
        elevation: 0,
        floating: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox(),
        toolbarHeight: 100,
        titleTextStyle: TextStyle(
          fontSize: TConstants.fontSizeMd,
          color: TColors.base900.withOpacity(.8),
        ),
        title: Column(
          children: <Widget>[
            const Gap(15),

            /// Buscar tarefas
            MySearchBar(
              hintText: 'Buscar task',
              onPressed: () {},
            ),

            /// Filtros
            const FiltersBarTasks(),
          ],
        ),
      );
}

class _Tasks extends StatelessWidget {
  const _Tasks();

  @override
  Widget build(BuildContext context) => BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) => SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final task = state.tasks[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TConstants.defaultMargin,
                  vertical: 5,
                ),
                child: CardTask(
                  task: task,
                  onTap: () => Get.toNamed(
                    AppRoutes.taskDetails,
                    parameters: {'id': task.id},
                  ),
                ),
              );
            },
            childCount: state.tasks.length,
          ),
        ),
      );
}

class _TasksEmpty extends StatelessWidget {
  const _TasksEmpty();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: <Widget>[
            /// Título
            const Text(
              'Nenhuma task encontrada',
              style: TextStyle(
                fontSize: TConstants.fontSizeLg,
                color: TColors.base300,
              ),
            ),

            const Gap(15),

            /// Imagem
            Image.asset(
              'assets/tasks_empty.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
}
