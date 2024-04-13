part of 'delete_account_cubit.dart';

class DeleteAccountState extends Equatable {
  const DeleteAccountState({
    this.email = const EmailInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final EmailInput email;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, isValid, status];

  DeleteAccountState copyWith({
    EmailInput? email,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return DeleteAccountState(
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
