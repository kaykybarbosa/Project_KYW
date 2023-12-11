import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/widgets/card_project.dart';

import '../../domain/blocs/blocs_export.dart';

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
          itemCount: projects.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return CardProject(
              project: projects[index],
              onTap: () {
                context.push(MyRoutes.chat);
              },
            );
          },
        );
      },
    );
  }
}
