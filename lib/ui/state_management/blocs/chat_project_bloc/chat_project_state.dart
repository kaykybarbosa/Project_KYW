part of 'chat_project_bloc.dart';

class ChatProjectState extends Equatable {
  const ChatProjectState({
    required this.allTasks,
    required this.pendingTasks,
    required this.completedTasks,
    required this.incompletedTasks,
  });

  final List<Task> allTasks;
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> incompletedTasks;

  @override
  List<Object> get props => [
        allTasks,
        pendingTasks,
        completedTasks,
        incompletedTasks,
      ];

  ChatProjectState copyWith({
    List<Task>? allTasks,
    List<Task>? pendingTasks,
    List<Task>? completedTasks,
    List<Task>? incompletedTasks,
  }) {
    return ChatProjectState(
      allTasks: allTasks ?? this.allTasks,
      pendingTasks: pendingTasks ?? this.pendingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      incompletedTasks: incompletedTasks ?? this.incompletedTasks,
    );
  }
}

final class ChatProjectInitial extends ChatProjectState {
  const ChatProjectInitial({
    required super.allTasks,
    required super.pendingTasks,
    required super.completedTasks,
    required super.incompletedTasks,
  });
}
