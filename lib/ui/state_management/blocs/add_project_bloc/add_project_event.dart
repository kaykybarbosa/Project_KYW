// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_project_bloc.dart';

sealed class AddProjectEvent extends Equatable {
  const AddProjectEvent();

  @override
  List<Object> get props => [];
}

class PickerImage extends AddProjectEvent {
  const PickerImage({this.fromGallery = false});

  final bool fromGallery;

  @override
  List<Object> get props => [fromGallery];
}

class RemoveImage extends AddProjectEvent {}

class TitleChanged extends AddProjectEvent {
  const TitleChanged({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}

class DescriptionChanged extends AddProjectEvent {
  const DescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class EmailChanged extends AddProjectEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class InvitedFriends extends AddProjectEvent {}

class ChangedCurrentPage extends AddProjectEvent {}

class RemoveFriends extends AddProjectEvent {
  const RemoveFriends({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class FormSubmittedd extends AddProjectEvent {}
