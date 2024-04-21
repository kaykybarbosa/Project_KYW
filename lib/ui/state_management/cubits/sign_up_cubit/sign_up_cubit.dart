import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/requests_models/user_register_request.dart';
import 'package:kyw_management/ui/state_management/models_input/models_states_export.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required IAuthRepository authRepository})
      : _repository = authRepository,
        super(const SignUpState());

  final IAuthRepository _repository;

  void nameChanged(String value) {
    final name = Name.dirty(value);

    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([
          name,
          state.email,
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
          password,
        ]),
      ),
    );
  }

  void obscureChanged() => emit(state.copyWith(obscureText: !state.obscureText));

  void formSubmitted() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    var request = UserRegisterRequest(
      nickname: state.name.value,
      email: state.email.value,
      password: state.password.value,
    );
    var result = await _repository.register(request);

    result.fold(
      (success) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
      (failure) => emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }
}
