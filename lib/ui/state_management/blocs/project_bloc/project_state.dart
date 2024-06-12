part of 'project_bloc.dart';

class ProjectState extends Equatable {
  ProjectState({
    this.projects = const [],
    DetailProjectResponse? detailProject,
    this.status = ProjectStatus.initial,
    this.messages = const [],
    this.members = const [],
  }) : detailProject = detailProject ?? DetailProjectResponse.empty();

  final List<ProjectResponse> projects;
  final DetailProjectResponse detailProject;
  final ProjectStatus status;
  final List<MessageResponse> messages;
  final List<MemberOfProjectResponse> members;

  @override
  List<Object?> get props => [
        projects,
        status,
        detailProject,
        messages,
      ];

  ProjectState copyWith({
    List<ProjectResponse>? projects,
    DetailProjectResponse? detailProject,
    ProjectStatus? status,
    List<MessageResponse>? messages,
    List<MemberOfProjectResponse>? members,
  }) =>
      ProjectState(
        projects: projects ?? this.projects,
        detailProject: detailProject ?? this.detailProject,
        status: status ?? ProjectStatus.initial,
        messages: messages ?? [],
        members: members ?? [],
      );
}

enum ProjectStatus {
  initial,

  inProgress,
  success,
  failure,

  detailInProgress,
  detailSuccess,
  detailFailure,

  newMessage,
}

extension ProjectStatusX on ProjectStatus {
  bool get isInProgress => this == ProjectStatus.inProgress;
  bool get isSuccess => this == ProjectStatus.success;
  bool get isFailure => this == ProjectStatus.failure;

  bool get isDetailsInProgress => this == ProjectStatus.detailInProgress;
  bool get isDetailSuccess => this == ProjectStatus.detailSuccess;
  bool get isDetailFailure => this == ProjectStatus.detailFailure;

  bool get isNewMessage => this == ProjectStatus.newMessage;
}
