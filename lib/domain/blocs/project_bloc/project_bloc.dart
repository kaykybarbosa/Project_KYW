import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/models/task.dart';

import '../blocs_export.dart';

part 'project_event.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(const ProjectState()) {
    on<AddProject>(_onAddProject);
    on<AddProjects>(_onAddListProject);
    on<UpdateProject>(_onUpdateProject);
    on<AddTaskProject>(_onAddTaskProject);
  }

  void _onAddProject(AddProject event, Emitter<ProjectState> emit) {
    emit(
      ProjectState(
        allProject: List.from(state.allProject)..insert(0, event.project),
      ),
    );
  }

  void _onAddListProject(AddProjects event, Emitter<ProjectState> emit) {
    List<Project> allProject = List.from(state.allProject)..addAll(event.projects);

    emit(ProjectState(allProject: allProject));
  }

  void _onUpdateProject(UpdateProject event, Emitter<ProjectState> emit) {}
  void _onAddTaskProject(AddTaskProject event, Emitter<ProjectState> emit) {
    final project = state.allProject.firstWhere((project) => project.id == event.projectId);
    List<Project> projects = state.allProject;
    project.tasks = List.from(project.tasks ?? [])..insert(0, event.task);

    var index = projects.indexOf(project);
    projects = List.from(projects)
      ..remove(project)
      ..insert(index, project);

    emit(state.copyWith(allProject: projects));
  }
}
