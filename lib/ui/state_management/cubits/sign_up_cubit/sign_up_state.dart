part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.obscureText = true,
  });

  final Name name;
  final EmailInput email;
  final PasswordInput password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final bool obscureText;

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        isValid,
        status,
        errorMessage,
        obscureText,
      ];

  SignUpState copyWith({
    Name? name,
    EmailInput? email,
    PasswordInput? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
    bool? obscureText,
  }) =>
      SignUpState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        status: status ?? this.status,
        errorMessage: errorMessage,
        obscureText: obscureText ?? this.obscureText,
      );
}
