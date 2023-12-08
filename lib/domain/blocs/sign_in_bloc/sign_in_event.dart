// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class NameSignUpChanged extends SignInEvent {
  const NameSignUpChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NameSignUpUnfocused extends SignInEvent {}

class EmailSignInChanged extends SignInEvent {
  const EmailSignInChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailSignInUnfocused extends SignInEvent {}

class NumberSignInChanged extends SignInEvent {
  const NumberSignInChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NumberSignInUnfocused extends SignInEvent {}

class PasswordSignInChanged extends SignInEvent {
  const PasswordSignInChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordSignInUnfocused extends SignInEvent {}

class FormSignInSubmitted extends SignInEvent {
  const FormSignInSubmitted({required this.formType});

  final String formType;

  @override
  List<Object> get props => [formType];
}

class ScreenChanged extends SignInEvent {}
