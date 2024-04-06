part of 'two_step_verification_cubit.dart';

class TwoStepVerificationState extends Equatable {
  const TwoStepVerificationState({
    this.email = const Email.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final Email email;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, isValid, status];

  TwoStepVerificationState copyWith({
    Email? email,
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
