import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String number;
  final String password;
  final String confirmPassword;
  final bool isActive;

  const UserModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.number = '',
    this.password = '',
    this.confirmPassword = '',
    this.isActive = true,
  });

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
      id: map['id'],
      name: map['name'],
      email: map['email'],
      number: map['number'],
      password: map['password'],
      confirmPassword: map['confirmPassword'],
      isActive: map['isActive'] ?? true,
    );
  }
}
