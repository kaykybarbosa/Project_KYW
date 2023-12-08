import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/models_export.dart';

enum FormType { signIn, signUp }

class AuthState extends Equatable {
  const AuthState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.number = '',
    this.password = const Password.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.formType = FormType.signIn,
  });

  final Name name;
  final Email email;
  final String number;
  final Password password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final FormType formType;

  @override
  List<Object> get props => [name, email, number, password, status, formType];

  AuthState copyWith({
    Name? name,
    Email? email,
    String? number,
    Password? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    FormType? formType,
  }) {
    return AuthState(
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      formType: formType ?? this.formType,
    );
  }
}
