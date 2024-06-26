import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/request/create_task_request.dart';
import 'package:kyw_management/data/dtos/response/member_of_project_response.dart';
import 'package:kyw_management/data/repositories/task_repository.dart';
import 'package:kyw_management/domain/enums/criticality_enum.dart';
import 'package:kyw_management/ui/state_management/models_input/create_task/task_category_input.dart';
import 'package:kyw_management/ui/state_management/models_input/create_task/task_date_of_conclusion_input.dart';
import 'package:kyw_management/ui/state_management/models_input/create_task/task_title_input.dart';
import 'package:kyw_management/utils/formaters.dart';
import 'package:result_dart/result_dart.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit(ITaskRepository taskRepository, {required String projectId})
      : _repository = taskRepository,
        super(CreateTaskState(projectId: projectId));

  final ITaskRepository _repository;

  void addMembersOfProject(List<MemberOfProjectResponse> members) {
    emit(state.copyWith(members: members));
  }

  void addAttributedTo(MemberOfProjectResponse member) {
    final members = List<MemberOfProjectResponse>.from(state.attributedTo);

    members.add(member);

    emit(state.copyWith(attributedTo: members));
  }

  void removeAttributedTo(MemberOfProjectResponse member) {
    final members = List<MemberOfProjectResponse>.from(state.attributedTo);

    members.remove(member);

    emit(state.copyWith(attributedTo: members));
  }

  void titleChanged(String value) {
    final title = TaskTitleInput.dirty(value);

    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([
          title,
          state.dateOfConclusion,
          state.category,
        ]),
      ),
    );
  }

  void categoryChanged(String value) {
    final category = TaskCategoryInput.dirty(value);

    emit(
      state.copyWith(
        category: category,
        isValid: Formz.validate([
          state.title,
          state.dateOfConclusion,
          category,
        ]),
      ),
    );
  }

  void dateOfConclusionChanged(String value) {
    final date = TaskDateOfConclusionInput.dirty(value);

    emit(
      state.copyWith(
        dateOfConclusion: date,
        isValid: Formz.validate([
          state.title,
          date,
          state.category,
        ]),
      ),
    );
  }

  void descriptionChanged(String value) {
    emit(
      state.copyWith(
        description: value,
        isValid: Formz.validate([
          state.title,
          state.dateOfConclusion,
          state.category,
        ]),
      ),
    );
  }

  void boldDescriptionChanged() {
    final styles = List<TaskDescriptionStyle>.from(state.descriptionStyles);

    if (styles.contains(TaskDescriptionStyle.bold)) {
      styles.remove(TaskDescriptionStyle.bold);
    } else {
      styles.add(TaskDescriptionStyle.bold);
    }

    emit(state.copyWith(descriptionStyles: styles));
  }

  void italicDescriptionChanged() {
    final styles = List<TaskDescriptionStyle>.from(state.descriptionStyles);

    if (styles.contains(TaskDescriptionStyle.italic)) {
      styles.remove(TaskDescriptionStyle.italic);
    } else {
      styles.add(TaskDescriptionStyle.italic);
    }

    emit(state.copyWith(descriptionStyles: styles));
  }

  void submitForm() {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    DateTime? date = Formatters.tryParseDate(state.dateOfConclusion.value);

    date ??= DateTime.now();

    final request = CreateTaskRequest(
      title: state.title.value,
      criticality: state.category.value,
      deadline: date.toIso8601String(),
      description: state.description,
      projectId: state.projectId,
      attributedTo: state.attributedTo.map((member) => member.id).toList(),
    );

    final result = _repository.createTask(request);

    result.fold(
      (success) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
      (failure) => emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }
}
