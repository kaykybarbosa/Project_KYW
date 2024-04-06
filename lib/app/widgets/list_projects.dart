import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/widgets/card_project.dart';
import 'package:kyw_management/domain/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/domain/blocs/project_bloc/project_state.dart';
import 'package:kyw_management/domain/services/routers/my_routes.dart';

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
