class UserResponse {
  const UserResponse({
    this.userId = '',
    this.nickname = '',
  });

  final String userId;
  final String nickname;

  factory UserResponse.fromMap(Map<String, dynamic> map) => UserResponse(
        userId: map['userId'],
        nickname: map['nickname'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'nickname': nickname,
      };
}
