import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/project.dart';

import '../project_export.dart';

part 'project_event.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(const ProjectState()) {
    on<AddProject>(_onAddProject);
    on<AddProjects>(_onAddListProject);
  }

  void _onAddProject(AddProject event, Emitter<ProjectState> emit) {
    emit(
      ProjectState(
        allProject: List.from(state.allProject)..add(event.project),
      ),
    );
  }

  void _onAddListProject(AddProjects event, Emitter<ProjectState> emit) {
    List<Project> allProject = List.from(state.allProject)
      ..addAll(event.projects);

    emit(ProjectState(allProject: allProject));
  }
}
