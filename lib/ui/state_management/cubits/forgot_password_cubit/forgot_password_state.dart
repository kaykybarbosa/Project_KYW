part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.email = const EmailInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final EmailInput email;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, isValid, status];

  ForgotPasswordState copyWith({
    EmailInput? email,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
