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
}
