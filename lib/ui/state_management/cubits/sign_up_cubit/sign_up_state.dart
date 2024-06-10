part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const NameInput.pure(),
    this.email = const EmailInput.pure(),
    this.phone = const PhoneInput.pure(),
    this.password = const PasswordInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.obscureText = true,
  });

  final NameInput name;
  final EmailInput email;
  final PhoneInput phone;
  final PasswordInput password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final bool obscureText;

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        password,
        isValid,
        status,
        errorMessage,
        obscureText,
      ];

  SignUpState copyWith({
    NameInput? name,
    EmailInput? email,
    PhoneInput? phone,
    PasswordInput? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
    bool? obscureText,
  }) =>
      SignUpState(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        status: status ?? this.status,
        errorMessage: errorMessage,
        obscureText: obscureText ?? this.obscureText,
      );
}
