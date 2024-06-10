import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/domain/enums/criticality_enum.dart';
import 'package:kyw_management/ui/state_management/models_input/create_task/task_category_input.dart';
import 'package:kyw_management/ui/state_management/models_input/create_task/task_date_of_conclusion_input.dart';
import 'package:kyw_management/ui/state_management/models_input/create_task/task_title_input.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskState());

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
}
