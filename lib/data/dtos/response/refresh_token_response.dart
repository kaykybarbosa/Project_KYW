import 'dart:convert';

class RefreshTokenResponse {
  RefreshTokenResponse({
    required this.token,
    required this.refreshToken,
  });

  final String token;
  final String refreshToken;

  factory RefreshTokenResponse.fromMap(Map<String, dynamic> map) => RefreshTokenResponse(
        token: map['accessToken'],
        refreshToken: map['refreshToken'],
      );

  factory RefreshTokenResponse.fromJson(String source) =>
      RefreshTokenResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
