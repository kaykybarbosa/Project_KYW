// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_task_cubit.dart';

class AddTaskState extends Equatable {
  final TitleInput title;
  final CategoryInput category;
  final DescriptionInput description;
  final String dateOfConclusion;
  final List users;
  final bool arrowDownPressed;
  final int heightDescription;
  final bool isValid;
  final FormzSubmissionStatus status;
  const AddTaskState({
    required this.title,
    required this.category,
    required this.description,
    required this.dateOfConclusion,
    required this.users,
    required this.arrowDownPressed,
    required this.heightDescription,
    required this.isValid,
    required this.status,
  });

  @override
  List<Object> get props => [
        title,
        category,
        description,
        dateOfConclusion,
        users,
        arrowDownPressed,
        heightDescription,
        isValid,
        status,
      ];

  AddTaskState copyWith({
    TitleInput? title,
    CategoryInput? category,
    DescriptionInput? description,
    String? dateOfConclusion,
    List? users,
    bool? arrowDownPressed,
    int? heightDescription,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return AddTaskState(
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      dateOfConclusion: dateOfConclusion ?? this.dateOfConclusion,
      users: users ?? this.users,
      arrowDownPressed: arrowDownPressed ?? this.arrowDownPressed,
      heightDescription: heightDescription ?? this.heightDescription,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}

final class AddTaskInitial extends AddTaskState {
  const AddTaskInitial({
    required super.title,
    required super.category,
    required super.description,
    required super.dateOfConclusion,
    required super.users,
    required super.arrowDownPressed,
    required super.heightDescription,
    required super.isValid,
    required super.status,
  });
}
