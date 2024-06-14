import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/dtos/response/all_tasks_response.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_sliver_list.dart';
import 'package:kyw_management/ui/screens/tasks/widgets/my_modal_filter_task.dart';
import 'package:kyw_management/ui/state_management/cubits/task_cubit/task_cubit.dart';
import 'package:kyw_management/ui/widgets/card_task.dart';
import 'package:kyw_management/ui/widgets/my_order.dart';
import 'package:kyw_management/ui/widgets/my_search_bar.dart';
import 'package:kyw_management/ui/widgets/my_two_filters.dart';
import 'package:kyw_management/ui/widgets/tasks_in_progress.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/texts.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  void _getAllTasks() => context.read<TaskCubit>().getAllTasks();

  @override
  void initState() {
    super.initState();

    _getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return Scaffold(
          body: state.status.isInProgress
              ? const TasksInProgress()
              : state.tasks.isNotEmpty
                  ? _Body(state.tasks)
                  : const _TasksEmpty(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.tasks);

  final List<TaskResponse> tasks;

  Future<dynamic> myModalBottom(
    BuildContext context,
    Widget child,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => child,
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Buscar tarefas
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TConstants.defaultMargin,
              vertical: 10,
            ),
            child: MySearchBar(
              hintText: TTexts.hintTextTask,
              onPressed: () {},
            ),
          ),

          /// Filtros
          MyTwoFilters(
            /// -- Filtrar
            filterOnTap: () => myModalBottom(context, const MyModalFilterTask()),

            /// -- Ordenar
            orderOnTap: () => myModalBottom(
              context,
              const MyOrder(currentScreen: Screens.task),
            ),
          ),

          /// Lista de tarefas
          Expanded(
            child: MySliverList(
              childCount: tasks.length,
              builder: (_, index) => Padding(
                padding: EdgeInsets.only(bottom: index != tasks.length - 1 ? 10 : 0),
                child: CardTask(
                  task: tasks[index],
                  onTap: () => Get.toNamed(
                    AppRoutes.taskDetails,
                    parameters: {'id': tasks[index].id},
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

class _TasksEmpty extends StatelessWidget {
  const _TasksEmpty();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Nenhuma task encontrada',
              style: TextStyle(
                fontSize: TConstants.fontSizeLg,
                color: TColors.base300,
              ),
            ),
            const Gap(15),
            Image.asset(
              'assets/tasks_empty_2.png',
              fit: BoxFit.cover,
              width: Get.width * .7,
              height: Get.width * .7,
            ),
          ],
        ),
      );
}
