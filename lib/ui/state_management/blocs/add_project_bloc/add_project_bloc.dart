import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models_input/models_states_export.dart';

part 'add_project_event.dart';
part 'add_project_state.dart';

const addProjectInitial = AddProjectInitial(
  title: TitleInput.pure(),
  description: DescriptionInput.pure(),
  email: EmailInput.pure(),
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
    final title = TitleInput.dirty(event.title);

    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([title, state.description]),
      ),
    );
  }

  void _onDescriptionChangedAddProject(
    DescriptionChangedAddProject event,
    Emitter<AddProjectState> emit,
  ) {
    final description = DescriptionInput.dirty(event.description);

    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([state.title, description]),
      ),
    );
  }

  void _onEmailChangedAddProject(
    EmailChangedAddProject event,
    Emitter<AddProjectState> emit,
  ) {
    final email = EmailInput.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.title, state.description, email]),
      ),
    );
  }

  void _onInvitedFriendsAddProject(
    InvitedFriendsAddProject event,
    Emitter<AddProjectState> emit,
  ) {
    if (!state.isValid) return;

    List<EmailInput> invitedFriends = state.invitedFriends;

    if (state.email.isValid) {
      invitedFriends = List.from(invitedFriends)..add(state.email);
    }

    emit(
      state.copyWith(
        email: const EmailInput.pure(),
        invitedFriends: invitedFriends,
        isValid: Formz.validate([
          state.title,
          state.description,
          state.email,
        ]),
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
