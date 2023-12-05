part of 'projects_bloc.dart';

sealed class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];
}

class AddProject extends ProjectsEvent {
  const AddProject({required this.project});

  final Project project;

  @override
  List<Object> get props => [project];
}

class AddProjects extends ProjectsEvent {
  const AddProjects({required this.projects});

  final List<Project> projects;

  @override
  List<Object> get props => [projects];
}
