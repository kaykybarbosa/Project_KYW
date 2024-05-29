part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class GetAllProjects extends ProjectEvent {
  const GetAllProjects();
}

class AddProject extends ProjectEvent {
  const AddProject({required this.projects});

  final List<ProjectModel> projects;

  @override
  List<Object> get props => [projects];
}

class GetProjectById extends ProjectEvent {
  const GetProjectById(this.projectId);

  final String projectId;

  @override
  List<Object> get props => [projectId];
}

class ConnectWebSocket extends ProjectEvent {
  const ConnectWebSocket();
}

class SendMessage extends ProjectEvent {
  const SendMessage(this.projectId,{ required this.message});

  final String projectId;
  final String message;

    @override
  List<Object> get props => [message];
}
