import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/models/task.dart';

import '../../repositories/project_repository.dart';
import '../blocs_export.dart';

part 'project_event.dart';

final projects = ProjectRepository().projects;

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectState(allProject: projects)) {
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
    // Finding project
    final project = state.allProject.firstWhere((project) => project.id == event.projectId);

    // Getting the index
    List<Project> allProjects = state.allProject;
    var index = allProjects.indexOf(project);

    // Emitting new state
    emit(state.copyWith(allProject: List.from(state.allProject)..insert(index, project)));

    // Updating tasks
    project.tasks = List.from(project.tasks ?? [])..insert(0, event.task);

    allProjects = List.from(state.allProject)..remove(project);

    emit(state.copyWith(allProject: allProjects));
  }
}
