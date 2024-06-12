// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MemberOfProjectResponse extends Equatable {
  const MemberOfProjectResponse({
    required this.id,
    required this.nickname,
    required this.email,
    required this.phone,
    required this.notifications,
    required this.avatarUrl,
  });

  final String id;
  final String nickname;
  final String email;
  final String phone;
  final List? notifications;
  final String? avatarUrl;

  @override
  List<Object?> get props => [
        id,
        nickname,
        email,
        phone,
        notifications,
        avatarUrl,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'nickname': nickname,
        'email': email,
        'phone': phone,
        'notifications': notifications,
        'avatarUrl': avatarUrl,
      };

  factory MemberOfProjectResponse.fromMap(Map<String, dynamic> map) => MemberOfProjectResponse(
        id: map['id'],
        nickname: map['nickname'],
        email: map['email'],
        phone: map['phone'],
        notifications: map['notifications'],
        avatarUrl: map['avatarUrl'],
      );

  String toJson() => json.encode(toMap());

  factory MemberOfProjectResponse.fromJson(String source) => MemberOfProjectResponse.fromMap(json.decode(source));
}
