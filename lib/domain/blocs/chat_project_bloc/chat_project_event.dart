part of 'chat_project_bloc.dart';

sealed class ChatProjectEvent extends Equatable {
  const ChatProjectEvent();

  @override
  List<Object> get props => [];
}

class AddTaskChat extends ChatProjectEvent {
  const AddTaskChat({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class UpdateTaskChat extends ChatProjectEvent {
  const UpdateTaskChat({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}
