// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CurrentUserModel extends Equatable {
  const CurrentUserModel({
    this.id = '',
    this.token = '',
    this.type = '',
    this.refreshToken = '',
    this.nickname = '',
    this.email = '',
    this.phone = '',
    this.avatarUrl,
    this.roles = const [],
  });

  final String id;
  final String token;
  final String type;
  final String refreshToken;
  final String nickname;
  final String email;
  final String phone;
  final String? avatarUrl;
  final List<String> roles;

  Map<String, dynamic> toMap() => {
        'id': id,
        'token': token,
        'type': type,
        'refreshToken': refreshToken,
        'nickname': nickname,
        'email': email,
        'phone': phone,
        'avatarUrl': avatarUrl,
        'roles': roles,
      };

  static CurrentUserModel fromMap(Map<String, dynamic> map) => CurrentUserModel(
        id: map['id'],
        token: map['token'],
        type: map['type'],
        refreshToken: map['refreshToken'],
        nickname: map['nickname'],
        email: map['email'],
        phone: map['phone'] ?? '',
        avatarUrl: map['avatarUrl'],
        roles: map['email'].isNotEmpty ? List<String>.from(map['roles']) : [],
      );

  String toJson() => json.encode(toMap());

  factory CurrentUserModel.fromJson(String source) =>
      CurrentUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CurrentUserModel copyWith({
    String? id,
    String? token,
    String? type,
    String? refreshToken,
    String? nickname,
    String? email,
    String? phone,
    String? avatarUrl,
    List<String>? roles,
  }) =>
      CurrentUserModel(
        id: id ?? this.id,
        token: token ?? this.token,
        type: type ?? this.type,
        refreshToken: refreshToken ?? this.refreshToken,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        roles: roles ?? this.roles,
      );

  @override
  List<Object?> get props => [
        id,
        token,
        refreshToken,
        type,
        nickname,
        email,
        phone,
        roles,
        avatarUrl,
      ];
}
