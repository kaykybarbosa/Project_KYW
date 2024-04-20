import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/requests_models/user_register_request.dart';

import '../../models_input/models_states_export.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required IAuthRepository authRepository})
      : _repository = authRepository,
        super(const SignUpState()) {
    on<NameSignUpChanged>(_onNameSignUpChanged);
    on<EmailSignUpChanged>(_onEmailSignUpChanged);
    on<PasswordSignUpChanged>(_onPasswordSignUpChanged);
    on<FormSignUpSubmitted>(_onFormSignUpSubmitted);
  }

  final IAuthRepository _repository;

  void _onNameSignUpChanged(
    NameSignUpChanged event,
    Emitter<SignUpState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([name, state.email, state.password]),
    ));
  }

  void _onEmailSignUpChanged(
    EmailSignUpChanged event,
    Emitter<SignUpState> emit,
  ) {
    final email = EmailInput.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.name, email, state.password]),
      ),
    );
  }

  void _onPasswordSignUpChanged(
    PasswordSignUpChanged event,
    Emitter<SignUpState> emit,
  ) {
    final password = PasswordInput.dirty(event.password);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.name, state.email, password]),
    ));
  }

  void _onFormSignUpSubmitted(
    FormSignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
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
