// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserResponse extends Equatable {
  final String id;
  final String nickname;
  final String email;
  final String phone;
  final List? notification;
  final String? avatarUrl;

  const UserResponse({
    this.id = '',
    this.nickname = '',
    this.email = '',
    this.phone = '',
    this.notification,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        id,
        nickname,
        email,
        phone,
        notification,
        avatarUrl,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'nickname': nickname,
        'email': email,
        'phone': phone,
        'notification': notification,
        'avatarUrl': avatarUrl,
      };

  factory UserResponse.fromMap(Map<String, dynamic> map) => UserResponse(
        id: map['id'],
        nickname: map['nickname'],
        email: map['email'],
        phone: map['phone'],
        notification: map['notification'],
        avatarUrl: map['avatarUrl'],
      );

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) => UserResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
