// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class EmailSignInChanged extends SignInEvent {
  const EmailSignInChanged({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordSignInChanged extends SignInEvent {
  const PasswordSignInChanged({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [password];
}

class FormSignInSubmitted extends SignInEvent {}
