import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/data/dtos/all_projects_response.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/domain/models/project_model.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({required IProjectRepository projectRepository})
      : _repository = projectRepository,
        super(ProjectState()) {
    on<GetAllProjects>(_onGetAllProject);
    on<AddProject>(_onAddProject);
  }

  final IProjectRepository _repository;

  void _onGetAllProject(GetAllProjects event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    var result = await _repository.getAllProjects();

    result.fold(
      (success) => emit(state.copyWith(
        allProjects: success,
        status: FormzSubmissionStatus.success,
      )),
      (failure) => emit(state.copyWith(status: FormzSubmissionStatus.failure)),
    );
  }

  void _onAddProject(AddProject event, Emitter<ProjectState> emit) {}
}
