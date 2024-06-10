import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/data/dtos/request/user_login_request.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/services/configure_login_service.dart';
import 'package:kyw_management/domain/models/auth_user_model.dart';
import 'package:kyw_management/ui/state_management/models_input/email_input.dart';
import 'package:kyw_management/ui/state_management/models_input/password_input.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required IAuthRepository authRepository, required IAuthSettingsService authSettings})
      : _repository = authRepository,
        _settings = authSettings,
        super(const SignInState());

  final IAuthRepository _repository;
  final IAuthSettingsService _settings;

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);

    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password]),
    ));
  }

  void obscureChanged() => emit(state.copyWith(obscureText: !state.obscureText));

  void formSubmitted() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    var request = UserLoginRequest(email: state.email.value, password: state.password.value);
    var result = await _repository.login(request);

    result.fold(
      (success) async {
        var authUser = AuthUserModel(email: state.email.value, password: state.password.value);

        await _settings.signIn(authUser: authUser, currentUser: success);

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      },
      (failure) => emit(state.copyWith(status: FormzSubmissionStatus.failure)),
    );
  }
}
