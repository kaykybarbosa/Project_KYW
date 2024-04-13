import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models_input/models_states_export.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<NameSignUpChanged>(_onNameSignUpChanged);
    on<EmailSignUpChanged>(_onEmailSignUpChanged);
    on<PasswordSignUpChanged>(_onPasswordSignUpChanged);
    on<FormSignUpSubmitted>(_onFormSignUpSubmitted);
  }

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
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
