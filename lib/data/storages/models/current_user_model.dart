// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurrentUserModel {
  CurrentUserModel({
    required this.id,
    required this.token,
    required this.type,
    required this.refreshToken,
    required this.nickname,
    required this.email,
    required this.roles,
  });

  final String id;
  final String token;
  final String type;
  final String refreshToken;
  final String nickname;
  final String email;
  final List<String> roles;

  Map<String, dynamic> toMap() => {
        'id': id,
        'token': token,
        'type': type,
        'refreshToken': refreshToken,
        'nickname': nickname,
        'email': email,
        'roles': roles,
      };

  static CurrentUserModel fromMap(Map<String, dynamic> map) => CurrentUserModel(
        id: map['id'],
        token: map['token'],
        type: map['type'],
        refreshToken: map['refreshToken'],
        nickname: map['nickname'],
        email: map['email'],
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
    List<String>? roles,
  }) =>
      CurrentUserModel(
        id: id ?? this.id,
        token: token ?? this.token,
        type: type ?? this.type,
        refreshToken: refreshToken ?? this.refreshToken,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        roles: roles ?? this.roles,
      );
}
