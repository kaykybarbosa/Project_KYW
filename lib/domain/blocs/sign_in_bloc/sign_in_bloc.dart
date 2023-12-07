import 'package:formz/formz.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

import '../../models/models_export.dart';
import '../sign_in_export.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> with ValidationsMixin {
  SignInBloc() : super(const SignInState()) {
    on<EmailSignInChanged>(_onEmailSignInChange);
    on<NumberSignInChanged>(_onNumberSignInChange);
    on<PasswordSignInChanged>(_onPasswordSignInChange);
    on<EmailSignInUnfocused>(_onEmailSignInUnfocused);
    on<PasswordSignInUnfocused>(_onPasswordSignInUnfocused);
    on<FormSignInSubmitted>(_onFormSignInSubmitted);
  }

  void _onEmailSignInChange(
    EmailSignInChanged event,
    Emitter<SignInState> emit,
  ) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email.isValid ? email : Email.pure(event.email),
        isValid: Formz.validate([email, state.password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onNumberSignInChange(
    NumberSignInChanged event,
    Emitter<SignInState> emit,
  ) {}

  void _onPasswordSignInChange(
    PasswordSignInChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password.isValid ? password : Password.pure(event.password),
        isValid: Formz.validate([state.email, password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onEmailSignInUnfocused(
    EmailSignInUnfocused event,
    Emitter<SignInState> emit,
  ) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onPasswordSignInUnfocused(
    PasswordSignInUnfocused event,
    Emitter<SignInState> emit,
  ) {
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onFormSignInSubmitted(
    FormSignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    print('=======================');
    print('${state.status}');

    emit(
      state.copyWith(
        email: email,
        password: password,
        isValid: Formz.validate([email, password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
  }
}
