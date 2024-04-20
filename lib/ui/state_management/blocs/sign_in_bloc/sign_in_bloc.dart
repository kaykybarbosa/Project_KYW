import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/requests_models/user_login_request.dart';

import '../../models_input/models_states_export.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required IAuthRepository authRepository})
      : _repository = authRepository,
        super(const SignInState()) {
    on<EmailSignInChanged>(_onEmailSignInChanged);
    on<PasswordSignInChanged>(_onPasswordSignInChanged);
    on<FormSignInSubmitted>(_onFormSignInSubmitted);
  }

  final IAuthRepository _repository;

  void _onEmailSignInChanged(
    EmailSignInChanged event,
    Emitter<SignInState> emit,
  ) {
    final email = EmailInput.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordSignInChanged(
    PasswordSignInChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = PasswordInput.dirty(event.password);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password]),
    ));
  }

  void _onFormSignInSubmitted(
    FormSignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    var request = UserLoginRequest(email: state.email.value, password: state.password.value);
    var result = await _repository.login(request);

    result.fold(
      (success) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
      (failure) => emit(state.copyWith(status: FormzSubmissionStatus.failure)),
    );
  }
}
