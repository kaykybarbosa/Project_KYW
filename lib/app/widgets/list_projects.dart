import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/widgets/card_project.dart';

import '../../domain/blocs/bloc_export.dart';

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

  // void _scrollListener() {
  //   setState(() {
  //     // Up
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       widget.showFilterBar(false);
  //     }

  //     // Down
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       widget.showFilterBar(true);
  //     }

  //     // To disable FilterBar scrolling
  //     if (_scrollController.position.pixels == 0.0) {
  //       widget.showFilterBar(true);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
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
