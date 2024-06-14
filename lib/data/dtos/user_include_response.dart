// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/env/env.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserIncludeResponse extends Equatable {
  UserIncludeResponse({
    this.id = 0,
    this.userId = '',
    this.nickname = '',
    this.avatarUrl,
  });

  int id;
  final String userId;
  final String nickname;
  final String? avatarUrl;

  @override
  List<Object?> get props => [id, userId, nickname];

  bool get isCurrentUser => userId == AppController.instance.currentUser.id;

  String? get avatarUrlLocal => avatarUrl?.replaceAll(RegExp(r'localhost'), Env.LOCALHOST);

  factory UserIncludeResponse.fromMap(Map<String, dynamic> map) => UserIncludeResponse(
        userId: map['userId'] ?? '',
        nickname: map['nickname'] ?? '',
        avatarUrl: map['avatarUrl'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'nickname': nickname,
        'avatarUrl': avatarUrl,
      };
}
