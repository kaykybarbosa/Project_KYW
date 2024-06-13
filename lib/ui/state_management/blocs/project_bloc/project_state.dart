part of 'project_bloc.dart';

class ProjectState extends Equatable {
  ProjectState({
    this.projects = const [],
    DetailProjectResponse? detailProject,
    this.status = ProjectStatus.initial,
    this.messages = const [],
    this.members = const [],
    this.tasks = const [],
  }) : projectDetails = detailProject ?? DetailProjectResponse.empty();

  final List<ProjectResponse> projects;
  final DetailProjectResponse projectDetails;
  final ProjectStatus status;
  final List<MessageResponse> messages;
  final List<MemberOfProjectResponse> members;
  final List<TaskResponse> tasks;

  @override
  List<Object?> get props => [
        projects,
        projectDetails,
        status,
        messages,
        members,
        tasks,
      ];

  ProjectState copyWith({
    List<ProjectResponse>? projects,
    DetailProjectResponse? projectDetails,
    ProjectStatus? status,
    List<MessageResponse>? messages,
    List<MemberOfProjectResponse>? members,
    List<TaskResponse>? tasks,
  }) =>
      ProjectState(
        projects: projects ?? this.projects,
        detailProject: projectDetails ?? this.projectDetails,
        status: status ?? ProjectStatus.initial,
        messages: messages ?? this.messages,
        members: members ?? this.members,
        tasks: tasks ?? this.tasks,
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

  taskInProgress,
  taskSuccess,
  taskFailure,
}

extension ProjectStatusX on ProjectStatus {
  bool get isInProgress => this == ProjectStatus.inProgress;
  bool get isSuccess => this == ProjectStatus.success;
  bool get isFailure => this == ProjectStatus.failure;

  bool get isDetailsInProgress => this == ProjectStatus.detailInProgress;
  bool get isDetailSuccess => this == ProjectStatus.detailSuccess;
  bool get isDetailFailure => this == ProjectStatus.detailFailure;

  bool get isNewMessage => this == ProjectStatus.newMessage;

  bool get isTaskInProgress => this == ProjectStatus.taskInProgress;
  bool get isTaskSuccess => this == ProjectStatus.taskSuccess;
}
