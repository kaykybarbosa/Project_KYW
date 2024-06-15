import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/ui/state_management/models_input/email_input.dart';

part 'add_member_project_state.dart';

class AddMemberProjectCubit extends Cubit<AddMemberProjectState> {
  AddMemberProjectCubit(this._repository) : super(const AddMemberProjectState());

  final IProjectRepository _repository;

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ),
    );
  }

  void submitForm(String projectId) async {
    if (state.email.value.isEmpty) {
      emit(state.copyWith(isValid: false));
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _repository.addMemberByEmail(
      projectId,
      email: state.email.value,
    );

    result.fold(
      (success) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
      (failure) => emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }
}
