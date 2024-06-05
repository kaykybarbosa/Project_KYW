part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class GetAllProjects extends ProjectEvent {
  const GetAllProjects();
}

class GetProjectById extends ProjectEvent {
  const GetProjectById(this.projectId);

  final String projectId;

  @override
  List<Object> get props => [projectId];
}

class SubscribeInProjectsWs extends ProjectEvent {
  const SubscribeInProjectsWs(this.onReceivedMessage);

  final Function(MessageResponse) onReceivedMessage;
}

class HasNewMessage extends ProjectEvent {
  const HasNewMessage(this.message);

  final MessageResponse message;
}

class DeleteMessages extends ProjectEvent {
  const DeleteMessages(this.projectId);

  final String projectId;
}
