// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_email_cubit.dart';

class ForgotEmailState extends Equatable {
  const ForgotEmailState({
    this.email = const EmailInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final EmailInput email;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, isValid, status];

  ForgotEmailState copyWith({
    EmailInput? email,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ForgotEmailState(
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
