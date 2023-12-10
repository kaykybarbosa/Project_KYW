part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class NameSignUpChanged extends SignUpEvent {
  const NameSignUpChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class EmailSignUpChanged extends SignUpEvent {
  const EmailSignUpChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordSignUpChanged extends SignUpEvent {
  const PasswordSignUpChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class FormSignUpSubmitted extends SignUpEvent {}
