part of 'authenticate_user_cubit.dart';

class AuthenticateUserState extends Equatable {
  const AuthenticateUserState({
    this.password = const PasswordInput.pure(),
    this.obscureText = true,
    this.isValid = false,
    this.status = AuthenticateUserStatus.initial,
    this.errorMessage,
  });

  final PasswordInput password;
  final bool obscureText;
  final bool isValid;
  final AuthenticateUserStatus status;
  final String? errorMessage;

  AuthenticateUserState copyWith({
    PasswordInput? password,
    bool? obscureText,
    bool? isValid,
    AuthenticateUserStatus? status,
    String? errorMessage,
  }) =>
      AuthenticateUserState(
        password: password ?? this.password,
        obscureText: obscureText ?? this.obscureText,
        isValid: isValid ?? this.isValid,
        status: status ?? AuthenticateUserStatus.initial,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [password, obscureText, isValid, status, errorMessage];
}

enum AuthenticateUserStatus {
  initial,
  success,
  inProgress,
  failure,
}

extension AuthenticateUserStatusZ on AuthenticateUserStatus {
  bool get isInitial => this == AuthenticateUserStatus.initial;

  bool get isInProgress => this == AuthenticateUserStatus.inProgress;

  bool get isSuccess => this == AuthenticateUserStatus.success;

  bool get isFailure => this == AuthenticateUserStatus.failure;
}
