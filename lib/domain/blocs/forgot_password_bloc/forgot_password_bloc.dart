import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models_states/models_states_export.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<EmailForgotPasswordChanged>(_onEmailForgotPasswordChanged);
    on<CodeForgotPasswordChanged>(_onCodeForgotPasswordChanged);
    on<EmailForgotPasswordUnfocused>(_onEmailForgotPasswordUnfocused);
    on<CodeForgotPasswordUnfocused>(_onCodeForgotPasswordUnfocused);
    on<StepForgotPasswordChanged>(_onStepForgotPasswordChanged);
    on<DisposeForgotPassword>(_onDisposeForgotPassword);
    on<FormForgotPasswordSubmitted>(_onFormForgotPasswordSubmitted);
  }

  void _onEmailForgotPasswordChanged(
    EmailForgotPasswordChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    final email = Email.dirty(event.email);

    emit(state.copyWith(
      email: email.isValid ? email : Email.pure(event.email),
      isValid: Formz.validate([email]),
      step: StepsForgotPassword.gettingEmail,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onCodeForgotPasswordChanged(
    CodeForgotPasswordChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    final code = Code.dirty(event.code);

    emit(state.copyWith(
      code: code.isValid ? code : Code.pure(event.code),
      isValid: Formz.validate([code]),
      step: StepsForgotPassword.validationCode,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onEmailForgotPasswordUnfocused(
    EmailForgotPasswordUnfocused event,
    Emitter<ForgotPasswordState> emit,
  ) {
    if (state.step != StepsForgotPassword.gettingEmail) {
      final email = Email.dirty(state.email.value);

      emit(state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
        step: StepsForgotPassword.gettingEmail,
        status: FormzSubmissionStatus.initial,
      ));
    }
  }

  void _onCodeForgotPasswordUnfocused(
    CodeForgotPasswordUnfocused event,
    Emitter<ForgotPasswordState> emit,
  ) {
    final code = Code.dirty(state.code.value);

    emit(state.copyWith(
      code: code,
      isValid: Formz.validate([code]),
      step: StepsForgotPassword.validationCode,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onStepForgotPasswordChanged(
    StepForgotPasswordChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    var step = state.step;

    if (state.step == StepsForgotPassword.gettingEmail) {
      step = StepsForgotPassword.validationCode;
    } else {
      step = StepsForgotPassword.gettingEmail;
    }
    emit(ForgotPasswordState(step: step));
  }

  void _onDisposeForgotPassword(
    DisposeForgotPassword event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(const ForgotPasswordState());
  }

  void _onFormForgotPasswordSubmitted(
    FormForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    final code = Code.dirty(state.code.value);

    var isValid = state.isValid;
    var step = state.step;

    if (step == StepsForgotPassword.gettingEmail) {
      isValid = Formz.validate([email]);
    } else if (step != StepsForgotPassword.goToValidationCode) {
      isValid = Formz.validate([code]);
      step = StepsForgotPassword.validationCode;
    }

    emit(state.copyWith(
      email: email,
      code: code,
      isValid: isValid,
      step: step,
      status: FormzSubmissionStatus.initial,
    ));

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      var isValid = state.isValid;
      var step = state.step;
      var status = state.status;

      if (step == StepsForgotPassword.gettingEmail) {
        // Sendig code to user e-mail
        await Future<void>.delayed(const Duration(seconds: 2));

        // If send e-mail has success
        step = StepsForgotPassword.goToValidationCode;
        status = FormzSubmissionStatus.success;
      } else if (step != StepsForgotPassword.goToValidationCode) {
        // Confirmation code validation
        var codeConfirmationExample = '123456';
        var codeIsValid =
            state.code.validator(state.code.value, codeConfirmationExample);

        if (codeIsValid != null) {
          isValid = false;
          status = FormzSubmissionStatus.failure;
        } else {
          status = FormzSubmissionStatus.success;
        }

        await Future<void>.delayed(const Duration(seconds: 2));
      }

      emit(state.copyWith(
        isValid: isValid,
        step: step,
        status: status,
      ));
    }
  }
}
