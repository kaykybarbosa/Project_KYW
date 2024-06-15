import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthUserModel extends Equatable {
  const AuthUserModel({
    this.email = '',
    this.password = '',
  });

  final String email;
  final String password;

  AuthUserModel copyWith({
    String? email,
    String? password,
  }) =>
      AuthUserModel(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'email': email,
        'password': password,
      };

  String toJson() => json.encode(toMap());

  factory AuthUserModel.fromMap(Map<String, dynamic> map) => AuthUserModel(
        email: map['email'],
        password: map['password'],
      );

  factory AuthUserModel.fromJson(String source) => AuthUserModel.fromMap(json.decode(source));
}
