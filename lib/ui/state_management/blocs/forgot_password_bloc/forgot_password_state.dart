part of 'forgot_password_bloc.dart';

enum StepsForgotPassword { gettingEmail, goToValidationCode, validationCode }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.email = const EmailInput.pure(),
    this.code = const CodeInput.pure(),
    this.isValid = false,
    this.step = StepsForgotPassword.gettingEmail,
    this.status = FormzSubmissionStatus.initial,
  });

  final EmailInput email;
  final CodeInput code;
  final bool isValid;
  final StepsForgotPassword step;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, code, step, status];

  ForgotPasswordState copyWith({
    EmailInput? email,
    CodeInput? code,
    bool? isValid,
    StepsForgotPassword? step,
    FormzSubmissionStatus? status,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      code: code ?? this.code,
      isValid: isValid ?? this.isValid,
      step: step ?? this.step,
      status: status ?? this.status,
    );
  }
}
