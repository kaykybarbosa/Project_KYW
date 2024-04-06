import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_sliver_list.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/widgets/card_project.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        var projects = state.allProject;

        return MySliverList(
          childCount: projects.length,
          builder: (_, index) {
            return CardProject(
              project: projects[index],
              onTap: () => Get.toNamed(AppRoutes.chat, parameters: {'id': '$index'}),
            );
          },
        );
      },
    );
  }
}
