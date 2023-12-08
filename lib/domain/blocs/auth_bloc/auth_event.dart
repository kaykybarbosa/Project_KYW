// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class NameAuthChanged extends AuthEvent {
  const NameAuthChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NameAuthUnfocused extends AuthEvent {}

class EmailAuthChanged extends AuthEvent {
  const EmailAuthChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailAuthUnfocused extends AuthEvent {}

class NumberAuthChanged extends AuthEvent {
  const NumberAuthChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NumberAuthUnfocused extends AuthEvent {}

class PasswordAuthChanged extends AuthEvent {
  const PasswordAuthChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordAuthUnfocused extends AuthEvent {}

class FormAuthSubmitted extends AuthEvent {
  const FormAuthSubmitted({required this.formType});

  final String formType;

  @override
  List<Object> get props => [formType];
}

class ScreenChanged extends AuthEvent {}
