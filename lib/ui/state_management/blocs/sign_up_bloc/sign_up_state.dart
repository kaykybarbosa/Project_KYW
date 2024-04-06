// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });
  final Name name;
  final Email email;
  final Password password;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [name, email, password, isValid, status];

  SignUpState copyWith({
    Name? name,
    Email? email,
    Password? password,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
