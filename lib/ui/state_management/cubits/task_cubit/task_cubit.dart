import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/response/all_tasks_response.dart';
import 'package:kyw_management/data/repositories/task_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(ITaskRepository taskRepository)
      : _repository = taskRepository,
        super(const TaskState());

  final ITaskRepository _repository;

  void getAllTasks() async {
    emit(state.copyWith(status: TaskCubitStatus.inProgress));

    final result = await _repository.getAllTasks();

    result.fold(
      (success) => emit(state.copyWith(
        tasksOficial: success,
        status: TaskCubitStatus.success,
      )),
      (failure) => emit(state.copyWith(
        status: TaskCubitStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }

  void getTaskById(String taskId) async {
    emit(state.copyWith(status: TaskCubitStatus.inProgress));

    final result = await _repository.getTaskById(taskId);

    result.fold(
      (success) => emit(state.copyWith(
        taskDetails: success,
        status: TaskCubitStatus.success,
      )),
      (failure) => emit(state.copyWith(
        status: TaskCubitStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }
}
