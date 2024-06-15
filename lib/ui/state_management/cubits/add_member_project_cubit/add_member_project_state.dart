// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_member_project_cubit.dart';

class AddMemberProjectState extends Equatable {
  const AddMemberProjectState({
    this.email = const EmailInput.pure(),
    this.invitedMembers = const [],
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final EmailInput email;
  final List<String> invitedMembers;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        email,
        invitedMembers,
        status,
        isValid,
        errorMessage,
      ];

  AddMemberProjectState copyWith({
    EmailInput? email,
    List<String>? invitedMembers,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return AddMemberProjectState(
      email: email ?? this.email,
      invitedMembers: invitedMembers ?? this.invitedMembers,
      status: status ?? FormzSubmissionStatus.initial,
      isValid: isValid ?? false,
      errorMessage: errorMessage,
    );
  }
}
