part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.password = const PasswordInput.pure(),
    this.confirmedPassword = const ConfirmedPasswordInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final PasswordInput password;
  final ConfirmedPasswordInput confirmedPassword;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [password, confirmedPassword, isValid, status];

  ChangePasswordState copyWith({
    PasswordInput? password,
    ConfirmedPasswordInput? confirmedPassword,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ChangePasswordState(
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
