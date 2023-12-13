part of 'add_project_cubit.dart';

class AddProjectState extends Equatable {
  final Title title;
  final Description description;
  final List<Email> invitedFriends;
  final bool isValid;
  final FormzSubmissionStatus status;

  const AddProjectState({
    required this.title,
    required this.description,
    required this.invitedFriends,
    required this.isValid,
    required this.status,
  });

  @override
  List<Object> get props =>
      [title, description, invitedFriends, isValid, status];

  AddProjectState copyWith({
    Title? title,
    Description? description,
    List<Email>? invitedFriends,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return AddProjectState(
      title: title ?? this.title,
      description: description ?? this.description,
      invitedFriends: invitedFriends ?? this.invitedFriends,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}

final class AddProjectInitial extends AddProjectState {
  const AddProjectInitial(
      {required super.title,
      required super.description,
      required super.invitedFriends,
      required super.isValid,
      required super.status});
}
