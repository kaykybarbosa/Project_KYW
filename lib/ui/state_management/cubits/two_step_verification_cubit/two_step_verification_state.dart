part of 'two_step_verification_cubit.dart';

class TwoStepVerificationState extends Equatable {
  const TwoStepVerificationState({
    this.email = const EmailInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final EmailInput email;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, isValid, status];

  TwoStepVerificationState copyWith({
    EmailInput? email,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return TwoStepVerificationState(
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
