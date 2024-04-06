import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String number;
  final String password;
  final String confirmPassword;
  bool? isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.password,
    required this.confirmPassword,
    this.isActive,
  }) {
    isActive = isActive ?? true;
  }

  UserModel pure({
    String? id,
    String? name,
    String? email,
    String? number,
    String? password,
    String? confirmPassword,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? '',
      name: name ?? '',
      email: email ?? '',
      number: number ?? '',
      password: password ?? '',
      confirmPassword: confirmPassword ?? '',
    );
  }

  @override
  List<Object?> get props => [name, email, number, password, confirmPassword, isActive];

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? number,
    String? password,
    String? confirmPassword,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'number': number,
      'password': password,
      'confirmPassword': confirmPassword,
      'isActive': isActive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      number: map['number'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
    );
  }
}
