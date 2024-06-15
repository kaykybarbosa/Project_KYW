import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/response/all_tasks_response.dart';
import 'package:kyw_management/data/dtos/response/detail_project_response.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/data/repositories/task_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit({required ITaskRepository taskRepository, required IProjectRepository projectRepository})
      : _repository = taskRepository,
        _projectRepository = projectRepository,
        super(const TaskState());

  final ITaskRepository _repository;
  final IProjectRepository _projectRepository;

  void getAllTasks() async {
    emit(state.copyWith(status: TaskCubitStatus.inProgress));

    final result = await _repository.getAllTasks();

    result.fold(
      (success) => emit(state.copyWith(
        tasksOficial: success,
        status: TaskCubitStatus.success,
      )),
      (failure) => emit(
        state.copyWith(
          status: TaskCubitStatus.failure,
          errorMessage: failure.message,
        ),
      ),
    );
  }

  void getTaskById(String taskId) async {
    emit(state.copyWith(status: TaskCubitStatus.inProgress));

    final result = await _repository.getTaskById(taskId);

    result.fold(
      (success) async {
        final projectResult = await _projectRepository.getProjectById(success.project!.projectId);

        if (projectResult.isSuccess()) {
          final project = projectResult.getOrNull()!;

          emit(
            state.copyWith(
              taskDetails: success,
              projectDetails: project,
              status: TaskCubitStatus.success,
            ),
          );

          return;
        }

        emit(
          state.copyWith(
            taskDetails: success,
            status: TaskCubitStatus.success,
          ),
        );
      },
      (failure) => emit(state.copyWith(
        status: TaskCubitStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }
}
