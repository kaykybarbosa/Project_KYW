import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyw_management/data/dtos/request/create_project_request.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/ui/state_management/models_input/description_input.dart';
import 'package:kyw_management/ui/state_management/models_input/email_input.dart';
import 'package:kyw_management/ui/state_management/models_input/title_input.dart';

part 'create_project_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  CreateProjectCubit(IProjectRepository projectRepository)
      : _repository = projectRepository,
        super(const CreateProjectState());

  final IProjectRepository _repository;

  void pickerImageFile({bool fromGallery = false}) async {
    try {
      final source = fromGallery ? ImageSource.gallery : ImageSource.camera;

      XFile? result = await ImagePicker().pickImage(source: source);

      if (result != null) {
        final image = File(result.path);

        emit(state.copyWith(image: image));
      } else {
        emit(state.copyWith());
      }
    } catch (e) {
      emit(state.copyWith());
    }
  }

  void removeImage() {
    emit(
      CreateProjectState(
        title: state.title,
        description: state.description,
        email: state.email,
        invitedMembers: state.invitedMembers,
        isValid: state.isValid,
        currentPage: state.currentPage,
      ),
    );
  }

  void titleChanged(String value) {
    final title = TitleInput.dirty(value);

    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([title]),
      ),
    );
  }

  void descriptionChanged(String value) {
    final description = DescriptionInput.dirty(value);

    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([state.title]),
      ),
    );
  }

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);

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

  void invitedMembers() {
    if (!state.isValid) return;

    List<EmailInput> invitedMembers = state.invitedMembers;

    if (state.email.isValid) {
      /// Verificando se e-mail já se encontra na lista
      final emailAlreadyExists = invitedMembers.firstWhereOrNull(
        (email) => email.value.toLowerCase() == state.email.value.toLowerCase(),
      );

      if (emailAlreadyExists != null) {
        emit(state.copyWith(status: CreateProjectStatus.emailAlreadyExists));
        return;
      }

      invitedMembers = List.from(invitedMembers)..add(state.email);
    }

    emit(
      state.copyWith(
        email: const EmailInput.pure(),
        invitedMembers: invitedMembers,
        status: CreateProjectStatus.emailAdded,
      ),
    );
  }

  void removeMember(String value) {
    List<EmailInput> invitedMembers = state.invitedMembers;

    invitedMembers = List.from(invitedMembers)
      ..removeWhere(
        (email) => email.value.toLowerCase() == value.toLowerCase(),
      );

    emit(state.copyWith(invitedMembers: invitedMembers));
  }

  void changePage() {
    final page = state.currentPage == 0 ? 1 : 0;

    emit(state.copyWith(currentPage: page));
  }

  void formSubmitted() async {
    emit(state.copyWith(status: CreateProjectStatus.inProgress));

    final request = CreateProjectRequest(
      name: state.title.value,
      description: state.description.value,
      members: state.invitedMembers.map((member) => member.value).toList(),
      image: state.image,
    );

    final result = await _repository.createProject(request);

    result.fold(
      (success) => emit(state.copyWith(status: CreateProjectStatus.success)),
      (failure) => emit(state.copyWith(
        status: CreateProjectStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }
}
