class RefreshTokenModel {
  RefreshTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.type,
  });

  final String accessToken;
  final String refreshToken;
  final String type;

  static RefreshTokenModel fromMap(Map<String, dynamic> map) => RefreshTokenModel(
        accessToken: map['accessToken'],
        refreshToken: map['refreshToken'],
        type: map['type'],
      );
}
