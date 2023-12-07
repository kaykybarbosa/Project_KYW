// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_form_bloc.dart';

sealed class MyFormEvent extends Equatable {
  const MyFormEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends MyFormEvent {
  const NameChanged({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}

class EmailChanged extends MyFormEvent {
  const EmailChanged({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

class NumberChanged extends MyFormEvent {
  const NumberChanged({
    required this.number,
  });

  final String number;

  @override
  List<Object> get props => [number];
}

class PasswordChanged extends MyFormEvent {
  const PasswordChanged({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends MyFormEvent {
  const ConfirmPasswordChanged({
    required this.confirmPassword,
  });

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class FormSubmitted extends MyFormEvent {}
