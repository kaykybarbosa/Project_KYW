import 'package:formz/formz.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

import '../../models/models_export.dart';
import '../sign_in_export.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> with ValidationsMixin {
  SignInBloc() : super(const SignInState()) {
    on<NameSignUpChanged>(_onNameSignUpChanged);
    on<EmailSignInChanged>(_onEmailSignInChanged);
    on<NumberSignInChanged>(_onNumberSignInChanged);
    on<PasswordSignInChanged>(_onPasswordSignInChanged);
    on<NameSignUpUnfocused>(_onNameSignUpUnfocused);
    on<EmailSignInUnfocused>(_onEmailSignInUnfocused);
    on<PasswordSignInUnfocused>(_onPasswordSignInUnfocused);
    on<FormSignInSubmitted>(_onFormSignInSubmitted);
  }

  void _onNameSignUpChanged(
    NameSignUpChanged event,
    Emitter<SignInState> emit,
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

  void _onEmailSignInChanged(
    EmailSignInChanged event,
    Emitter<SignInState> emit,
  ) {
    final email = Email.dirty(event.email);
    bool isValid = state.isValid;
    FormType formType = event.formType == FormType.signIn.name
        ? FormType.signIn
        : FormType.signUp;

    print('MUDANDO EMAIL');

    if (formType == FormType.signIn) {
      isValid = Formz.validate([email, state.password]);
    } else {
      isValid = Formz.validate([state.name, email, state.password]);
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

  void _onNumberSignInChanged(
    NumberSignInChanged event,
    Emitter<SignInState> emit,
  ) {}

  void _onPasswordSignInChanged(
    PasswordSignInChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = Password.dirty(event.password);
    bool isValid = state.isValid;
    FormType formType = event.formType == FormType.signIn.name
        ? FormType.signIn
        : FormType.signUp;

    if (formType == FormType.signIn) {
      isValid = Formz.validate([state.email, password]);
    } else {
      isValid = Formz.validate([state.name, state.email, password]);
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

  void _onNameSignUpUnfocused(
    NameSignUpUnfocused event,
    Emitter<SignInState> emit,
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

  void _onEmailSignInUnfocused(
    EmailSignInUnfocused event,
    Emitter<SignInState> emit,
  ) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]),
      status: FormzSubmissionStatus.initial,
      formType: FormType.signIn,
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
      formType: FormType.signIn,
    ));
  }

  void _onFormSignInSubmitted(
    FormSignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    final name = Name.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    bool isValid = state.isValid;
    FormType formType = event.formType == FormType.signIn.name
        ? FormType.signIn
        : FormType.signUp;

    if (formType == FormType.signIn) {
      isValid = Formz.validate([email, password]);
    } else {
      isValid = Formz.validate([name, email, password]);
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
    print('STATUS ${state.formType}');
    print('STATUS ${state.isValid}');
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
  }
}
