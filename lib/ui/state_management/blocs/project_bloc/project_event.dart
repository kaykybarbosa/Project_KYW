part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class AddProject extends ProjectEvent {
  const AddProject({required this.project});

  final Project project;

  @override
  List<Object> get props => [project];
}

class AddProjects extends ProjectEvent {
  const AddProjects({required this.projects});

  final List<Project> projects;

  @override
  List<Object> get props => [projects];
}

class UpdateProject extends ProjectEvent {
  const UpdateProject({required this.project});

  final Project project;

  @override
  List<Object> get props => [project];
}

class AddTaskProject extends ProjectEvent {
  const AddTaskProject({required this.projectId, required this.task});

  final String projectId;
  final Task task;

  @override
  List<Object> get props => [projectId, task];
}
