import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/models_export.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<EmailSignInChanged>(_onEmailSignInChanged);
    on<PasswordSignInChanged>(_onPasswordSignInChanged);
    on<FormSignInSubmitted>(_onFormSignInSubmitted);
  }

  void _onEmailSignInChanged(
    EmailSignInChanged event,
    Emitter<SignInState> emit,
  ) {
    final email = Email.dirty(event.email);
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
    final password = Password.dirty(event.password);
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
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
