import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/models_export.dart';

part 'add_project_state.dart';

class AddProjectCubit extends Cubit<AddProjectState> {
  AddProjectCubit()
      : super(
          const AddProjectInitial(
            title: Title.pure(),
            description: Description.pure(),
            invitedFriends: [],
            isValid: false,
            status: FormzSubmissionStatus.initial,
          ),
        );

  void titleChanged(String value) {
    final title = Title.dirty(value);

    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([title, state.description]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void descriptionChanged(String value) {
    final description = Description.dirty(value);

    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([state.title, description]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void addFriendChanged(String value) {
    final emailFriend = Email.dirty(value);

    List<Email> invitedFriends = [];

    if (emailFriend.isValid) {
      invitedFriends.add(emailFriend);
    }

    emit(
      state.copyWith(
        invitedFriends: invitedFriends,
        isValid: Formz.validate(
          [
            state.title,
            state.description,
            emailFriend,
          ],
        ),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void submitAddProject() {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
