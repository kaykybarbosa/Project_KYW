import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/domain/models/user_test.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/my_modal_filter.dart';

import '../../models_states/models_states_export.dart';

part 'add_task_state.dart';

const AddTaskState addTaskInitial = AddTaskState(
  title: TitleModel.pure(),
  category: Category.pure(),
  description: Description.pure(),
  dateOfConclusion: '',
  users: [],
  arrowDownPressed: false,
  heightDescription: 3,
  isValid: false,
  status: FormzSubmissionStatus.initial,
);

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(addTaskInitial);
  @override
  void onChange(Change<AddTaskState> change) {
    super.onChange(change);
  }

  void titleChanged(String value) {
    final title = TitleModel.dirty(value);

    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([title, state.description]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void categoryChanged(String value) {
    final category = Category.dirty(value);

    emit(
      state.copyWith(
        category: category,
        isValid: Formz.validate([state.title, category, state.description]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void descriptionChanged(String value) {
    final description = Description.dirty(value);

    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([state.title, state.category, description]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void dateOfConclusionChanged(DateTime? dateSelected) {
    final date = formatter.format(dateSelected ?? DateTime.now());

    emit(
      state.copyWith(
        dateOfConclusion: date,
        isValid: Formz.validate([state.title, state.category, state.description]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void usersChanged(UserTest user) {
    List<UserTest> users = List.from(state.users)..insert(0, user);

    emit(state.copyWith(
      users: users,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void arrowDownChanged(double? value) {
    var height = state.heightDescription;

    if (value != null) {
      if (value > 0 && height != 15) {
        height += 1;
      } else if (value < 0 && height != 3) {
        height -= 1;
      }
    }

    emit(state.copyWith(heightDescription: height));
  }

  void formAddTaskSubmitted() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
