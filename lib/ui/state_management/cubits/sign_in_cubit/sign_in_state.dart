part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.obscureText = true,
  });

  final EmailInput email;
  final PasswordInput password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final bool obscureText;

  @override
  List<Object?> get props => [
        email,
        password,
        isValid,
        status,
        errorMessage,
        obscureText,
      ];

  SignInState copyWith({
    EmailInput? email,
    PasswordInput? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
    bool? obscureText,
  }) =>
      SignInState(
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        status: status ?? this.status,
        errorMessage: errorMessage,
        obscureText: obscureText ?? this.obscureText,
      );
}
