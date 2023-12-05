import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/domain/blocs/bloc/projects_state.dart';

part 'projects_event.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(const ProjectsState()) {
    on<AddProject>(_onAddProject);
    on<AddProjects>(_onAddListProject);
  }

  void _onAddProject(AddProject event, Emitter<ProjectsState> emit) {
    final state = this.state;

    emit(
      ProjectsState(
        allProject: List.from(state.allProject)..add(event.project),
      ),
    );
  }

  void _onAddListProject(AddProjects event, Emitter<ProjectsState> emit) {
    final state = this.state;
    final projects = event.projects;

    List<Project> allProject = List.from(state.allProject)..addAll(projects);

    emit(ProjectsState(allProject: allProject));
  }
}
