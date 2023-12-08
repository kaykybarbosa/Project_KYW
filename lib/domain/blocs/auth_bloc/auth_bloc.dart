import 'package:formz/formz.dart';

import '../../models/models_export.dart';
import '../auth_export.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<NameAuthChanged>(_onNameAuthChanged);
    on<EmailAuthChanged>(_onEmailAuthChanged);
    on<NumberAuthChanged>(_onNumberAuthChanged);
    on<PasswordAuthChanged>(_onPasswordAuthChanged);
    on<NameAuthUnfocused>(_onNameAuthUnfocused);
    on<EmailAuthUnfocused>(_onEmailAuthUnfocused);
    on<PasswordAuthUnfocused>(_onPasswordAuthUnfocused);
    on<FormAuthSubmitted>(_onFormAuthSubmitted);
    on<ScreenChanged>(_onScreenChanged);
  }

  void _onNameAuthChanged(
    NameAuthChanged event,
    Emitter<AuthState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name.isValid ? name : Name.pure(event.name),
        isValid: Formz.validate([name, state.email, state.password]),
        status: FormzSubmissionStatus.initial,
        formType: FormType.signUp,
      ),
    );
  }

  void _onEmailAuthChanged(
    EmailAuthChanged event,
    Emitter<AuthState> emit,
  ) {
    final email = Email.dirty(event.email);
    bool isValid = state.isValid;
    FormType formType = state.formType;

    if (formType != FormType.signIn) {
      formType = FormType.signUp;
      isValid = Formz.validate([state.name, email, state.password]);
    } else {
      isValid = Formz.validate([email, state.password]);
    }

    emit(
      state.copyWith(
        email: email.isValid ? email : Email.pure(event.email),
        isValid: isValid,
        status: FormzSubmissionStatus.initial,
        formType: formType,
      ),
    );
  }

  void _onNumberAuthChanged(
    NumberAuthChanged event,
    Emitter<AuthState> emit,
  ) {}

  void _onPasswordAuthChanged(
    PasswordAuthChanged event,
    Emitter<AuthState> emit,
  ) {
    bool isValid = state.isValid;
    FormType formType = state.formType;
    final password = Password.dirty(event.password);

    if (formType != FormType.signIn) {
      formType = FormType.signUp;
      isValid = Formz.validate([state.name, state.email, password]);
    } else {
      isValid = Formz.validate([state.email, password]);
    }

    emit(
      state.copyWith(
        password: password.isValid ? password : Password.pure(event.password),
        isValid: isValid,
        status: FormzSubmissionStatus.initial,
        formType: formType,
      ),
    );
  }

  void _onNameAuthUnfocused(
    NameAuthUnfocused event,
    Emitter<AuthState> emit,
  ) {
    final name = Name.dirty(state.name.value);

    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.email, state.password]),
        status: FormzSubmissionStatus.initial,
        formType: FormType.signUp,
      ),
    );
  }

  void _onEmailAuthUnfocused(
    EmailAuthUnfocused event,
    Emitter<AuthState> emit,
  ) {
    final email = Email.dirty(state.email.value);
    bool isValid = state.isValid;
    FormType formType = state.formType;

    if (formType != FormType.signIn) {
      isValid = Formz.validate([state.name, email, state.password]);
      formType = FormType.signUp;
    } else {
      isValid = Formz.validate([email, state.password]);
    }

    emit(state.copyWith(
      email: email,
      isValid: isValid,
      status: FormzSubmissionStatus.initial,
      formType: formType,
    ));
  }

  void _onPasswordAuthUnfocused(
    PasswordAuthUnfocused event,
    Emitter<AuthState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    bool isValid = state.isValid;
    FormType formType = state.formType;

    if (formType != FormType.signIn) {
      isValid = Formz.validate([state.name, state.email, password]);
      formType = FormType.signUp;
    } else {
      isValid = Formz.validate([state.email, password]);
    }

    emit(state.copyWith(
      password: password,
      isValid: isValid,
      status: FormzSubmissionStatus.initial,
      formType: formType,
    ));
  }

  void _onFormAuthSubmitted(
    FormAuthSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final name = Name.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    bool isValid = state.isValid;
    FormType formType = state.formType;

    if (formType != FormType.signIn) {
      isValid = Formz.validate([name, email, password]);
      formType = FormType.signUp;
    } else {
      isValid = Formz.validate([email, password]);
    }

    emit(
      state.copyWith(
        name: name,
        email: email,
        password: password,
        isValid: isValid,
        status: FormzSubmissionStatus.initial,
        formType: formType,
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
  }

  void _onScreenChanged(
    ScreenChanged event,
    Emitter<AuthState> emit,
  ) {
    FormType formType =
        state.formType == FormType.signIn ? FormType.signUp : FormType.signIn;

    emit(AuthState(formType: formType));
  }
}
