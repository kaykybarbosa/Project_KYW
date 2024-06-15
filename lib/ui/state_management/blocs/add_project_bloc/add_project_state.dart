part of 'add_project_bloc.dart';

class AddProjectState extends Equatable {
  const AddProjectState({
    this.image,
    this.title = const TitleInput.pure(),
    this.description = const DescriptionInput.pure(),
    this.email = const EmailInput.pure(),
    this.invitedFriends = const [],
    this.isValid = false,
    this.status = AddProjectStatus.initial,
    this.currentPage = 0,
    this.errorMessage,
  });

  final File? image;
  final TitleInput title;
  final DescriptionInput description;
  final EmailInput email;
  final List<EmailInput> invitedFriends;
  final bool isValid;
  final AddProjectStatus status;
  final int currentPage;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        image,
        title,
        description,
        email,
        invitedFriends,
        isValid,
        status,
        currentPage,
        errorMessage,
      ];

  AddProjectState copyWith({
    File? image,
    TitleInput? title,
    DescriptionInput? description,
    EmailInput? email,
    List<EmailInput>? invitedFriends,
    bool? isValid,
    AddProjectStatus? status,
    int? currentPage,
    String? errorMessage,
  }) =>
      AddProjectState(
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description,
        email: email ?? this.email,
        invitedFriends: invitedFriends ?? this.invitedFriends,
        isValid: isValid ?? this.isValid,
        status: status ?? AddProjectStatus.initial,
        currentPage: currentPage ?? this.currentPage,
        errorMessage: errorMessage,
      );
}

enum AddProjectStatus {
  initial,
  success,
  failure,
  inProgress,
  emailAlreadyExists,
  emailAdded,

  pickerImageSuccess,
  pickerImageFailure,
}

extension AddProjectStatusX on AddProjectStatus {
  bool get isInitial => this == AddProjectStatus.initial;
  bool get isInProgress => this == AddProjectStatus.inProgress;
  bool get isSuccess => this == AddProjectStatus.success;
  bool get isFailure => this == AddProjectStatus.failure;
  bool get isEmailAlreadyExists => this == AddProjectStatus.emailAlreadyExists;
  bool get isEmailAdded => this == AddProjectStatus.emailAdded;

  bool get isPickerImageSuccess => this == AddProjectStatus.pickerImageSuccess;
  bool get isPickerImageFailure => this == AddProjectStatus.pickerImageFailure;
}
