part of 'project_bloc.dart';

class ProjectState extends Equatable {
  ProjectState({
    AllProjectsResponse? allProjects,
    DetailProjectResponse? detailProject,
    this.status = ProjectStatus.initial,
    this.messages = const [],
  })  : allProjects = allProjects ?? AllProjectsResponse.empty,
        detailProject = detailProject ?? DetailProjectResponse.empty();

  final AllProjectsResponse allProjects;
  final DetailProjectResponse detailProject;
  final ProjectStatus status;
  final List<MessageResponse> messages;

  @override
  List<Object?> get props => [
        allProjects,
        status,
        detailProject,
        messages,
      ];

  ProjectState copyWith({
    AllProjectsResponse? allProjects,
    DetailProjectResponse? detailProject,
    ProjectStatus? status,
    List<MessageResponse>? messages,
  }) =>
      ProjectState(
        allProjects: allProjects ?? this.allProjects,
        detailProject: detailProject ?? this.detailProject,
        status: status ?? ProjectStatus.initial,
        messages: messages ?? [],
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
