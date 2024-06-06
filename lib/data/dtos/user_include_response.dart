// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserIncludeResponse extends Equatable {
  UserIncludeResponse({
    this.id = 0,
    this.userId = '',
    this.nickname = '',
  });

  int id;
  final String userId;
  final String nickname;

  @override
  List<Object?> get props => [id, userId, nickname];

  factory UserIncludeResponse.fromMap(Map<String, dynamic> map) => UserIncludeResponse(
        userId: map['userId'],
        nickname: map['nickname'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'nickname': nickname,
      };
}
