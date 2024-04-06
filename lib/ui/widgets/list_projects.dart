import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/data/services/routers/my_routes.dart';
import 'package:kyw_management/domain/models/project.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_state.dart';
import 'package:kyw_management/ui/widgets/card_project.dart';

class ListProjects extends StatefulWidget {
  const ListProjects({super.key});

  @override
  State<ListProjects> createState() => _ListProjectsState();
}

class _ListProjectsState extends State<ListProjects> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        List<Project> projects = state.allProject;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 7.5),
          itemCount: projects.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return CardProject(
              project: projects[index],
              onTap: () {
                var route = "${AppRoutes.chat}/$index".replaceAll(':projectId/', '');
                GoRouter.of(context).push(route);
              },
            );
          },
        );
      },
    );
  }
}
