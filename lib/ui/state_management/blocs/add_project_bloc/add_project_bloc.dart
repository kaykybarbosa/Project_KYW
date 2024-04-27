import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

import '../../models_input/models_states_export.dart';

part 'add_project_event.dart';
part 'add_project_state.dart';

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  AddProjectBloc() : super(const AddProjectState()) {
    on<TitleChanged>(_onTitleChangedAddProject);
    on<DescriptionChanged>(_onDescriptionChangedAddProject);
    on<EmailChanged>(_onEmailChangedAddProject);
    on<InvitedFriends>(_onInvitedFriendsAddProject);
    on<RemoveFriends>(_onRemoveFriends);
    on<ChangedCurrentPage>(_onChangePage);
    on<FormSubmittedd>(_onFormSubmitteddAddProject);
  }

  void _onTitleChangedAddProject(
    TitleChanged event,
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
    DescriptionChanged event,
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
    EmailChanged event,
    Emitter<AddProjectState> emit,
  ) {
    final email = EmailInput.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.title,
          state.description,
          email,
        ]),
      ),
    );
  }

  void _onInvitedFriendsAddProject(
    InvitedFriends event,
    Emitter<AddProjectState> emit,
  ) {
    if (!state.isValid) return;

    List<EmailInput> invitedFriends = state.invitedFriends;

    if (state.email.isValid) {
      /// Verificando se e-mail já se encontra na lista
      var emailAlreadyExists = invitedFriends.firstWhereOrNull(
        (email) => email.value.toLowerCase() == state.email.value.toLowerCase(),
      );
      if (emailAlreadyExists != null) {
        emit(state.copyWith(status: AddProjectStatus.emailAlreadyExists));
        return;
      }

      invitedFriends = List.from(invitedFriends)..add(state.email);
    }

    emit(
      state.copyWith(
        email: const EmailInput.pure(),
        invitedFriends: invitedFriends,
        status: AddProjectStatus.emailAdded,
      ),
    );
  }

  void _onRemoveFriends(
    RemoveFriends event,
    Emitter<AddProjectState> emit,
  ) {
    List<EmailInput> invitedFriends = state.invitedFriends;

    invitedFriends = List.from(invitedFriends)
      ..removeWhere((email) => email.value.toLowerCase() == event.email.toLowerCase());

    emit(state.copyWith(invitedFriends: invitedFriends));
  }

  void _onChangePage(
    _,
    Emitter<AddProjectState> emit,
  ) {
    var page = state.currentPage == 0 ? 1 : 0;
    emit(state.copyWith(currentPage: page));
  }

  void _onFormSubmitteddAddProject(
    FormSubmittedd event,
    Emitter<AddProjectState> emit,
  ) {
    emit(const AddProjectState());
  }
}
