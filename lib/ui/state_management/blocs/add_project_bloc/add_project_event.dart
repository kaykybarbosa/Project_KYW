// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_project_bloc.dart';

sealed class AddProjectEvent extends Equatable {
  const AddProjectEvent();

  @override
  List<Object> get props => [];
}

class TitleChangedAddProject extends AddProjectEvent {
  const TitleChangedAddProject({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}

class DescriptionChangedAddProject extends AddProjectEvent {
  const DescriptionChangedAddProject({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class EmailChangedAddProject extends AddProjectEvent {
  const EmailChangedAddProject({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class InvitedFriendsAddProject extends AddProjectEvent {}

class RemoveFriendsAddProject extends AddProjectEvent {
  const RemoveFriendsAddProject({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class FormSubmitteddAddProject extends AddProjectEvent {}
