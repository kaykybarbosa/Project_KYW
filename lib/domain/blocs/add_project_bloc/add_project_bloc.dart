import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models_states/models_states_export.dart';

part 'add_project_event.dart';
part 'add_project_state.dart';

const addProjectInitial = AddProjectInitial(
  title: Title.pure(),
  description: Description.pure(),
  email: Email.pure(),
  invitedFriends: [],
  isValid: false,
  status: FormzSubmissionStatus.initial,
);

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  AddProjectBloc() : super(addProjectInitial) {
    on<TitleChangedAddProject>(_onTitleChangedAddProject);
    on<DescriptionChangedAddProject>(_onDescriptionChangedAddProject);
    on<EmailChangedAddProject>(_onEmailChangedAddProject);
    on<InvitedFriendsAddProject>(_onInvitedFriendsAddProject);
    on<FormSubmitteddAddProject>(_onFormSubmitteddAddProject);
  }

  void _onTitleChangedAddProject(
    TitleChangedAddProject event,
    Emitter<AddProjectState> emit,
  ) {
    final title = Title.dirty(event.title);

    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([title, state.description]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onDescriptionChangedAddProject(
    DescriptionChangedAddProject event,
    Emitter<AddProjectState> emit,
  ) {
    final description = Description.dirty(event.description);

    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([state.title, description]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onEmailChangedAddProject(
    EmailChangedAddProject event,
    Emitter<AddProjectState> emit,
  ) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.title, state.description, email]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onInvitedFriendsAddProject(
    InvitedFriendsAddProject event,
    Emitter<AddProjectState> emit,
  ) {
    if (!state.isValid) return;

    List<Email> invitedFriends = state.invitedFriends;

    if (state.email.isValid) {
      invitedFriends = List.from(invitedFriends)..add(state.email);
    }

    emit(
      state.copyWith(
        invitedFriends: invitedFriends,
        isValid: Formz.validate([state.title, state.description, state.email]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onFormSubmitteddAddProject(
    FormSubmitteddAddProject event,
    Emitter<AddProjectState> emit,
  ) {
    emit(addProjectInitial);
  }
}
