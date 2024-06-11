// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_task_cubit.dart';

// ignore: must_be_immutable
class CreateTaskState extends Equatable {
  CreateTaskState({
    required this.projectId,
    this.title = const TaskTitleInput.pure(),
    this.category = const TaskCategoryInput.pure(),
    this.dateOfConclusion = const TaskDateOfConclusionInput.pure(),
    this.members = const [],
    this.description = '',
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.descriptionStyles = const [],
    this.errorMessage,
  });

  final String projectId;
  final TaskTitleInput title;
  final TaskCategoryInput category;
  final TaskDateOfConclusionInput dateOfConclusion;
  final List<String> members;
  final String description;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  List<TaskDescriptionStyle> descriptionStyles;
  List<String> categories = [
    CriticalityEnumM.urgent,
    CriticalityEnumM.important,
    CriticalityEnumM.standard,
  ];

  @override
  List<Object?> get props => [
        projectId,
        title,
        category,
        dateOfConclusion,
        members,
        description,
        isValid,
        errorMessage,
        status,
        descriptionStyles,
        categories,
      ];

  CreateTaskState copyWith({
    String? projectId,
    TaskTitleInput? title,
    TaskCategoryInput? category,
    TaskDateOfConclusionInput? dateOfConclusion,
    List<String>? members,
    String? description,
    bool? isValid,
    FormzSubmissionStatus? status,
    List<TaskDescriptionStyle>? descriptionStyles,
    String? errorMessage,
  }) {
    return CreateTaskState(
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      category: category ?? this.category,
      dateOfConclusion: dateOfConclusion ?? this.dateOfConclusion,
      members: members ?? this.members,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
      status: status ?? FormzSubmissionStatus.initial,
      descriptionStyles: descriptionStyles ?? this.descriptionStyles,
      errorMessage: errorMessage,
    );
  }
}

enum TaskDescriptionStyle {
  normal,
  bold,
  italic,
}

extension TaskDescriptionStyleX on TaskDescriptionStyle {
  bool get isNormal => this == TaskDescriptionStyle.normal;
  bool get isBold => this == TaskDescriptionStyle.bold;
  bool get isItalic => this == TaskDescriptionStyle.italic;
}
