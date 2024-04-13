part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final EmailInput email;
  final PasswordInput password;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, password, isValid, status];

  SignInState copyWith({
    EmailInput? email,
    PasswordInput? password,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
