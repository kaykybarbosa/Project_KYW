class UserRegisterRequest {
  UserRegisterRequest({
    required this.nickname,
    required this.email,
    required this.password,
    required this.phone,
  });

  final String nickname;
  final String email;
  final String password;
  final String phone;

  Map<String, dynamic> toMap() => {
        'nickname': nickname,
        'email': email,
        'password': password,
        'phone': phone,
      };
}
