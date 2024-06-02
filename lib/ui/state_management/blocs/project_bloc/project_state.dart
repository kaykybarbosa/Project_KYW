part of 'project_bloc.dart';

class ProjectState extends Equatable {
  ProjectState({
    AllProjectsResponse? allProjects,
    ProjectResponse? detailProject,
    this.status = ProjectStatus.initial,
    this.messages = const [],
  })  : allProjects = allProjects ?? AllProjectsResponse.empty,
        detailProject = detailProject ?? ProjectResponse.empty();

  final AllProjectsResponse allProjects;
  final ProjectResponse detailProject;
  final ProjectStatus status;
  final List<MessageModel> messages;

  @override
  List<Object?> get props => [
        allProjects,
        status,
        detailProject,
        messages,
      ];

  ProjectState copyWith({
    AllProjectsResponse? allProjects,
    ProjectResponse? detailProject,
    ProjectStatus? status,
    List<MessageModel>? messages,
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
}
