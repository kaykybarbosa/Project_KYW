part of 'create_project_cubit.dart';

class CreateProjectState extends Equatable {
  const CreateProjectState({
    this.image,
    this.title = const TitleInput.pure(),
    this.description = const DescriptionInput.pure(),
    this.email = const EmailInput.pure(),
    this.invitedMembers = const [],
    this.isValid = false,
    this.status = CreateProjectStatus.initial,
    this.currentPage = 0,
    this.errorMessage,
  });

  final File? image;
  final TitleInput title;
  final DescriptionInput description;
  final EmailInput email;
  final List<EmailInput> invitedMembers;
  final bool isValid;
  final CreateProjectStatus status;
  final int currentPage;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        image,
        title,
        description,
        email,
        invitedMembers,
        isValid,
        status,
        currentPage,
        errorMessage,
      ];

  CreateProjectState copyWith({
    File? image,
    TitleInput? title,
    DescriptionInput? description,
    EmailInput? email,
    List<EmailInput>? invitedMembers,
    bool? isValid,
    CreateProjectStatus? status,
    int? currentPage,
    String? errorMessage,
  }) {
    return CreateProjectState(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      email: email ?? this.email,
      invitedMembers: invitedMembers ?? this.invitedMembers,
      isValid: isValid ?? this.isValid,
      status: status ?? CreateProjectStatus.initial,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }
}

enum CreateProjectStatus {
  initial,
  success,
  failure,
  inProgress,
  emailAlreadyExists,
  emailAdded,

  pickerImageSuccess,
  pickerImageFailure,
}

extension AddProjectStatusX on CreateProjectStatus {
  bool get isInitial => this == CreateProjectStatus.initial;
  bool get isInProgress => this == CreateProjectStatus.inProgress;
  bool get isSuccess => this == CreateProjectStatus.success;
  bool get isFailure => this == CreateProjectStatus.failure;
  bool get isEmailAlreadyExists => this == CreateProjectStatus.emailAlreadyExists;
  bool get isEmailAdded => this == CreateProjectStatus.emailAdded;

  bool get isPickerImageSuccess => this == CreateProjectStatus.pickerImageSuccess;
  bool get isPickerImageFailure => this == CreateProjectStatus.pickerImageFailure;
}
