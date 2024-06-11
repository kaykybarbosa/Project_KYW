// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_cubit.dart';

class TaskState extends Equatable {
  const TaskState({
    this.tasksOficial = const AllTasksResponse(),
    this.tasks = const AllTasksResponse(),
    this.taskDetails = const TaskResponse(),
    this.status = TaskCubitStatus.initial,
    this.errorMessage,
  });

  final AllTasksResponse tasksOficial;
  final AllTasksResponse tasks;
  final TaskResponse taskDetails;
  final TaskCubitStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        tasksOficial,
        tasks,
        status,
        taskDetails,
        errorMessage,
      ];

  TaskState copyWith({
    AllTasksResponse? tasksOficial,
    AllTasksResponse? tasks,
    TaskResponse? taskDetails,
    TaskCubitStatus? status,
    String? errorMessage,
  }) {
    return TaskState(
      tasksOficial: tasksOficial ?? this.tasksOficial,
      tasks: tasks ?? this.tasksOficial,
      taskDetails: taskDetails ?? this.taskDetails,
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
