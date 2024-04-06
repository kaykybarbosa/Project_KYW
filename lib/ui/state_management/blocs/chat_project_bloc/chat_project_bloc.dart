import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/models/task.dart';

part 'chat_project_event.dart';
part 'chat_project_state.dart';

class ChatProjectBloc extends Bloc<ChatProjectEvent, ChatProjectState> {
  ChatProjectBloc()
      : super(const ChatProjectInitial(
          allTasks: [],
          completedTasks: [],
          incompletedTasks: [],
          pendingTasks: [],
        )) {
    on<AddTaskChat>(_onAddTaskChat);
    on<UpdateTaskChat>(_onUpdateTaskChat);
  }

  void _onAddTaskChat(AddTaskChat event, Emitter<ChatProjectState> emit) {
    emit(state.copyWith(allTasks: List.from(state.allTasks)..insert(0, event.task)));
  }

  void _onUpdateTaskChat(UpdateTaskChat event, Emitter<ChatProjectState> emit) {}
}
