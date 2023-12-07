part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  // final String name;
  // final Email email;
  // final Password password;

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}
