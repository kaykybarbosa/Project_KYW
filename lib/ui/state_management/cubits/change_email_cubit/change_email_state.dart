// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_email_cubit.dart';

class ChangeEmailState extends Equatable {
  const ChangeEmailState({
    this.newEmail = const Email.pure(),
    this.currentEmail = const Email.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final Email newEmail;
  final Email currentEmail;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [newEmail, currentEmail, isValid, status];

  ChangeEmailState copyWith({
    Email? newEmail,
    Email? currentEmail,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ChangeEmailState(
      newEmail: newEmail ?? this.newEmail,
      currentEmail: currentEmail ?? this.currentEmail,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
