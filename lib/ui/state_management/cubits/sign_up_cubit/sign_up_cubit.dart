import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/request/user_register_request.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/domain/models/auth_user_model.dart';
import 'package:kyw_management/ui/state_management/models_input/email_input.dart';
import 'package:kyw_management/ui/state_management/models_input/name_input.dart';
import 'package:kyw_management/ui/state_management/models_input/password_input.dart';
import 'package:kyw_management/ui/state_management/models_input/phone_input.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required IAuthRepository authRepository, required AppController appController})
      : _repository = authRepository,
        _controller = appController,
        super(const SignUpState());

  final IAuthRepository _repository;
  final AppController _controller;

  void nameChanged(String value) {
    final name = NameInput.dirty(value);

    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([
          name,
          state.email,
          state.phone,
          state.password,
        ]),
      ),
    );
  }

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.name,
          email,
          state.phone,
          state.password,
        ]),
      ),
    );
  }

  void phoneChanged(String value) {
    final phone = PhoneInput.dirty(value);

    emit(
      state.copyWith(
        phone: phone,
        isValid: Formz.validate([
          state.name,
          state.email,
          phone,
          state.password,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.phone,
          password,
        ]),
      ),
    );
  }

  void obscureChanged() => emit(state.copyWith(obscureText: !state.obscureText));

  void formSubmitted() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final request = UserRegisterRequest(
      nickname: state.name.value,
      email: state.email.value,
      phone: state.phone.value,
      password: state.password.value,
    );
    final result = await _repository.register(request);

    result.fold(
      (success) async {
        final authUser = AuthUserModel(
          email: state.email.value,
          password: state.password.value,
        );
        await _controller.setAuthenticationUser(authUser);

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      },
      (failure) => emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }
}
