part of 'add_project_bloc.dart';

class AddProjectState extends Equatable {
  const AddProjectState({
    this.title = const TitleInput.pure(),
    this.description = const DescriptionInput.pure(),
    this.email = const EmailInput.pure(),
    this.invitedFriends = const [],
    this.isValid = false,
    this.status = AddProjectStatus.initial,
  });

  final TitleInput title;
  final DescriptionInput description;
  final EmailInput email;
  final List<EmailInput> invitedFriends;
  final bool isValid;
  final AddProjectStatus status;

  @override
  List<Object> get props => [
        title,
        description,
        email,
        invitedFriends,
        isValid,
        status,
      ];

  AddProjectState copyWith({
    TitleInput? title,
    DescriptionInput? description,
    EmailInput? email,
    List<EmailInput>? invitedFriends,
    bool? isValid,
    AddProjectStatus? status,
  }) =>
      AddProjectState(
        title: title ?? this.title,
        description: description ?? this.description,
        email: email ?? this.email,
        invitedFriends: invitedFriends ?? this.invitedFriends,
        isValid: isValid ?? this.isValid,
        status: status ?? AddProjectStatus.initial,
      );
}

enum AddProjectStatus {
  initial,
  success,
  failure,
  inProgress,
  emailAlreadyExists,
  emailAdded,
}

extension AddProjectStatusX on AddProjectStatus {
  bool get isInitial => this == AddProjectStatus.initial;
  bool get isInProgress => this == AddProjectStatus.inProgress;
  bool get isSuccess => this == AddProjectStatus.success;
  bool get isFailure => this == AddProjectStatus.failure;
  bool get isEmailAlreadyExists => this == AddProjectStatus.emailAlreadyExists;
  bool get isEmailAdded => this == AddProjectStatus.emailAdded;
}
