import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/project.dart';

import '../bloc_export.dart';

part 'projects_event.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(const ProjectsState()) {
    on<AddProject>(_onAddProject);
    on<AddProjects>(_onAddListProject);
  }

  void _onAddProject(AddProject event, Emitter<ProjectsState> emit) {
    emit(
      ProjectsState(
        allProject: List.from(state.allProject)..add(event.project),
      ),
    );
  }

  void _onAddListProject(AddProjects event, Emitter<ProjectsState> emit) {
    List<Project> allProject = List.from(state.allProject)
      ..addAll(event.projects);

    emit(ProjectsState(allProject: allProject));
  }
}
