import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/data/dtos/response/message_response.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_sliver_list.dart';
import 'package:kyw_management/ui/screens/project/widgets/my_modal_filter_project.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/widgets/card_project.dart';
import 'package:kyw_management/ui/widgets/my_order.dart';
import 'package:kyw_management/ui/widgets/my_search_bar.dart';
import 'package:kyw_management/ui/widgets/my_two_filters.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  void _getAllProjects() => context.read<ProjectBloc>().add(const GetAllProjects());

  void _onReceivedMessage(MessageResponse message) => context.read<ProjectBloc>().add(HasNewMessage(message));

  void _subscribeInProjectWS() => context.read<ProjectBloc>().add(SubscribeInProjectsWs(_onReceivedMessage));

  @override
  void initState() {
    super.initState();
    _getAllProjects();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<ProjectBloc, ProjectState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (_, state) {
          if (state.status.isSuccess) {
            _subscribeInProjectWS();
          }
        },
        builder: (_, state) => Scaffold(
          body: switch (state.status) {
            ProjectStatus.inProgress => const Center(child: CircularProgressIndicator()),
            ProjectStatus.failure => const Center(child: Text('Erro ao buscar os projetos')),
            _ => state.projects.isNotEmpty ? _AllProjects(projects: state.projects) : const _ProjectEmpty()
          },

          /// Adicionar projetos
          floatingActionButton: FloatingActionButton(
            backgroundColor: TColors.primary,
            child: const Icon(TIcons.add),
            onPressed: () => Get.toNamed(AppRoutes.createProject),
          ),
        ),
      );
}

class _AllProjects extends StatelessWidget {
  const _AllProjects({required this.projects});

  final List<ProjectResponse> projects;

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
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// Buscar projetos
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TConstants.defaultMargin,
            vertical: 10,
          ),
          child: MySearchBar(
            hintText: TTexts.hintTextProject,
            onPressed: () {},
          ),
        ),

        /// Filtros
        MyTwoFilters(
          /// -- Filtrar
          filterOnTap: () => myModalBottom(context, const MyModalFilterProject()),

          /// -- Ordenar
          orderOnTap: () => myModalBottom(
            context,
            const MyOrder(currentScreen: Screens.project),
          ),
        ),

        /// Lista de projetos
        Expanded(
          child: MySliverList(
            childCount: projects.length,
            builder: (_, index) => Padding(
              padding: EdgeInsets.only(bottom: index != projects.length - 1 ? 10 : 0),
              child: CardProject(
                project: projects[index],
                onTap: () => Get.toNamed(AppRoutes.chat, parameters: {'id': projects[index].id}),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProjectEmpty extends StatelessWidget {
  const _ProjectEmpty();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Nenhuma projeto encontrado',
              style: TextStyle(
                fontSize: TConstants.fontSizeLg,
                color: TColors.base300,
              ),
            ),
            const Gap(15),
            Image.asset(
              'assets/projects_empty.png',
              fit: BoxFit.cover,
              width: Get.width * .7,
              height: Get.width * .7,
            ),
          ],
        ),
      );
}
