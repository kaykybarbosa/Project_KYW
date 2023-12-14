part of 'add_project_bloc.dart';

class AddProjectState extends Equatable {
  final Title title;
  final Description description;
  final Email email;
  final List<Email> invitedFriends;
  final bool isValid;
  final FormzSubmissionStatus status;

  const AddProjectState({
    required this.title,
    required this.description,
    required this.email,
    required this.invitedFriends,
    required this.isValid,
    required this.status,
  });

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
    Title? title,
    Description? description,
    Email? email,
    List<Email>? invitedFriends,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return AddProjectState(
      title: title ?? this.title,
      description: description ?? this.description,
      email: email ?? this.email,
      invitedFriends: invitedFriends ?? this.invitedFriends,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}

final class AddProjectInitial extends AddProjectState {
  const AddProjectInitial({
    required super.title,
    required super.description,
    required super.email,
    required super.invitedFriends,
    required super.isValid,
    required super.status,
  });
}
