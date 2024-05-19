class UserResponse {
  UserResponse({
    required this.userId,
    required this.nickname,
  });

  String userId;
  String nickname;

  factory UserResponse.fromMap(Map<String, dynamic> map) => UserResponse(
        userId: map['userId'],
        nickname: map['nickname'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'nickname': nickname,
      };
}
