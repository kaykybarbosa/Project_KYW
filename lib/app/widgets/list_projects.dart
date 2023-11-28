import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/widgets/card_project.dart';

class ListProjects extends StatelessWidget {
  const ListProjects({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return CardProject(project: projects[index]);
      },
    );
  }
}
