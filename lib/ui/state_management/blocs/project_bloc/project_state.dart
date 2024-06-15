part of 'project_bloc.dart';

class ProjectState extends Equatable {
  ProjectState({
    this.projects = const [],
    DetailProjectResponse? detailProject,
    this.status = ProjectStatus.initial,
    this.messages = const [],
    this.members = const [],
    this.tasks = const [],
    this.errorMessage,
  }) : projectDetails = detailProject ?? DetailProjectResponse.empty();

  final List<ProjectResponse> projects;
  final DetailProjectResponse projectDetails;
  final ProjectStatus status;
  final List<MessageResponse> messages;
  final List<MemberOfProjectResponse> members;
  final List<TaskResponse> tasks;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        projects,
        projectDetails,
        status,
        messages,
        members,
        tasks,
        errorMessage,
      ];

  ///

  String getNicknamesOfMembers() {
    final currentUserId = AppController.instance.currentUser.id;
    final currentUser = members.firstWhereOrNull((member) => member.id == currentUserId);

    List<MemberOfProjectResponse> newMembers = [];

    if (currentUser != null) {
      newMembers = List.from(members)..remove(currentUser);
    }

    List<String> nicknames = newMembers.map((member) => member.nickname).toList();

    if (currentUser != null) {
      nicknames.add('Você');
    }

    return nicknames.join(', ');
  }

  ProjectState copyWith({
    List<ProjectResponse>? projects,
    DetailProjectResponse? projectDetails,
    ProjectStatus? status,
    List<MessageResponse>? messages,
    List<MemberOfProjectResponse>? members,
    List<TaskResponse>? tasks,
    String? errorMessage,
  }) =>
      ProjectState(
        projects: projects ?? this.projects,
        detailProject: projectDetails ?? this.projectDetails,
        status: status ?? ProjectStatus.initial,
        messages: messages ?? this.messages,
        members: members ?? this.members,
        tasks: tasks ?? this.tasks,
        errorMessage: errorMessage,
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

  signOutProjectInProgress,
  signOutProjectSuccess,
  signOutProjectFailure,
}

extension ProjectStatusX on ProjectStatus {
  bool get isInProgress => this == ProjectStatus.inProgress;
  bool get isSuccess => this == ProjectStatus.success;
  bool get isFailure => this == ProjectStatus.failure;

  bool get isDetailsInProgress => this == ProjectStatus.detailInProgress;
  bool get isDetailsSuccess => this == ProjectStatus.detailSuccess;
  bool get isDetailsFailure => this == ProjectStatus.detailFailure;

  bool get isNewMessage => this == ProjectStatus.newMessage;

  bool get isTaskInProgress => this == ProjectStatus.taskInProgress;
  bool get isTaskSuccess => this == ProjectStatus.taskSuccess;

  bool get signOutProjectInProgress => this == ProjectStatus.signOutProjectInProgress;
  bool get signOutProjectSuccess => this == ProjectStatus.signOutProjectSuccess;
  bool get signOutProjectFailure => this == ProjectStatus.signOutProjectFailure;
}
