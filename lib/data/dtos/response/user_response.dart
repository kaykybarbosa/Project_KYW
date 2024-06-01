// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserResponse extends Equatable {
  UserResponse({
    this.id = 0,
    this.userId = '',
    this.nickname = '',
  });

  int id;
  final String userId;
  final String nickname;

  @override
  List<Object?> get props => [id, userId, nickname];

  factory UserResponse.fromMap(Map<String, dynamic> map) => UserResponse(
        userId: map['userId'],
        nickname: map['nickname'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'nickname': nickname,
      };
}
