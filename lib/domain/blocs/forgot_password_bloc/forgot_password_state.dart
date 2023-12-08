part of 'forgot_password_bloc.dart';

enum StepsForgotPassword { gettingEmail, validationCode }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.email = const Email.pure(),
    this.code = const Code.pure(),
    this.isValid = false,
    this.step = StepsForgotPassword.gettingEmail,
    this.status = FormzSubmissionStatus.initial,
  });

  final Email email;
  final Code code;
  final bool isValid;
  final StepsForgotPassword step;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, code, step, status];

  ForgotPasswordState copyWith({
    Email? email,
    Code? code,
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
