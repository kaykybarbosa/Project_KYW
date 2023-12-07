import 'package:equatable/equatable.dart';

import '../bloc_export.dart';

class MyFormState extends Equatable {
  const MyFormState({
    this.name = '',
    this.email = '',
    this.number = '',
    this.password = '',
    this.confirmPassword = '',
    this.isValid = false,
    this.status = FormStatus.initial,
  });

  final String name;
  final String email;
  final String number;
  final String password;
  final String confirmPassword;
  final bool isValid;
  final FormStatus status;

  @override
  List<Object> get props =>
      [name, email, number, password, confirmPassword, status];

  MyFormState copyWith({
    String? name,
    String? email,
    String? number,
    String? password,
    String? confirmPassword,
    bool? isValid,
    FormStatus? status,
  }) {
    return MyFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
