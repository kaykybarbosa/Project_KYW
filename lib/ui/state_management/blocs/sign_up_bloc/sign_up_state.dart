// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });
  final Name name;
  final EmailInput email;
  final PasswordInput password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        isValid,
        status,
        errorMessage,
      ];

  SignUpState copyWith({
    Name? name,
    EmailInput? email,
    PasswordInput? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
