// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_cubit.dart';

class TaskState extends Equatable {
  const TaskState({
    this.tasksOficial = const [],
    this.tasks = const [],
    this.taskDetails = const TaskResponse(),
    this.projectDetails,
    this.status = TaskCubitStatus.initial,
    this.errorMessage,
  });

  final List<TaskResponse> tasksOficial;
  final List<TaskResponse> tasks;
  final TaskResponse taskDetails;
  final DetailProjectResponse? projectDetails;
  final TaskCubitStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        tasksOficial,
        tasks,
        status,
        taskDetails,
        projectDetails,
        errorMessage,
      ];

  TaskState copyWith({
    List<TaskResponse>? tasksOficial,
    List<TaskResponse>? tasks,
    TaskResponse? taskDetails,
    DetailProjectResponse? projectDetails,
    TaskCubitStatus? status,
    String? errorMessage,
  }) {
    return TaskState(
      tasksOficial: tasksOficial ?? this.tasksOficial,
      tasks: tasks ?? (tasksOficial ?? this.tasksOficial),
      taskDetails: taskDetails ?? this.taskDetails,
      projectDetails: projectDetails ?? this.projectDetails,
      status: status ?? TaskCubitStatus.initial,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum TaskCubitStatus {
  initial,
  success,
  failure,
  inProgress,
}

extension TaskStatusX on TaskCubitStatus {
  bool get isSuccess => this == TaskCubitStatus.success;
  bool get isFailure => this == TaskCubitStatus.failure;
  bool get isInProgress => this == TaskCubitStatus.inProgress;
}
