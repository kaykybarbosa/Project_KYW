// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/models_export.dart';

// ignore: must_be_immutable
class SignInState extends Equatable {
  const SignInState({
    this.email = const Email.pure(),
    this.number = '',
    this.password = const Password.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final Email email;
  final String number;
  final Password password;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, number, password, status];

  SignInState copyWith({
    Email? email,
    String? number,
    Password? password,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return SignInState(
      email: email ?? this.email,
      number: number ?? this.number,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
