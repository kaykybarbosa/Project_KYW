import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/screens/tasks/widgets/filters_bar_tasks.dart';
import 'package:kyw_management/ui/state_management/cubits/task_cubit/task_cubit.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';
import 'package:kyw_management/ui/widgets/my_search_bar.dart';
import 'package:kyw_management/ui/widgets/skelton_indicator.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class TasksProjectScreen extends StatelessWidget {
  const TasksProjectScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) => BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          body: const _Body(),
          floatingActionButton: FloatingActionButton(
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
  Widget build(BuildContext context) => BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(
              // horizontal: 15,
              // vertical: 10
              ),
          child: switch (state.status) {
            TaskCubitStatus.inProgress => const Text('data'),
            _ => const _TasksInProgress(),
          },
        ),
        // child:   Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     // _ => state.tasksOficial.tasks.isNotEmpty
        //     //     ? const Expanded(
        //     //         child: CustomScrollView(
        //     //           slivers: <Widget>[
        //     //             /// Header
        //     //             _HeaderTasks(),

        //     //             /// Tarefas
        //     //             _Tasks()
        //     //           ],
        //     //         ),
        //     //       )
        //     //     : const _TasksEmpty(),
        //   ],
        // ),
      );
}

class _TasksInProgress extends StatelessWidget {
  const _TasksInProgress();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SkeltonIndicator(
                  width: Get.width * .8,
                  height: 40,
                ),
                const SkeltonIndicator(
                  width: 40,
                  height: 40,
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SkeltonIndicator(
                  width: 100,
                  height: 40,
                ),
                SkeltonIndicator(
                  width: 100,
                  height: 40,
                ),
                SkeltonIndicator(
                  width: 100,
                  height: 40,
                ),
              ],
            ),
            const Gap(10),
            Column(
              children: List.generate(
                3,
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: SkeltonIndicator(
                    width: double.infinity,
                    height: 100,
                  ),
                ),
              ),
            ),
          ],
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
  Widget build(BuildContext context) => BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) => SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TConstants.defaultMargin,
                  vertical: 10,
                ),
                child: CardTask(task: state.tasks.tasks[index]),
              );
            },
            childCount: state.tasks.tasks.length,
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
