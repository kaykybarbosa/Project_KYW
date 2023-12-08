part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class EmailForgotPasswordChanged extends ForgotPasswordEvent {
  const EmailForgotPasswordChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailForgotPasswordUnfocused extends ForgotPasswordEvent {}

class CodeForgotPasswordChanged extends ForgotPasswordEvent {
  const CodeForgotPasswordChanged({required this.code});

  final String code;

  @override
  List<Object> get props => [code];
}

class CodeForgotPasswordUnfocused extends ForgotPasswordEvent {}

class FormForgotPasswordSubmitted extends ForgotPasswordEvent {}
