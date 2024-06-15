import 'dart:io';

import 'package:dio/dio.dart';

class UserRegisterRequest {
  UserRegisterRequest({
    required this.nickname,
    required this.email,
    required this.password,
    this.phone,
    this.image,
  });

  final String nickname;
  final String email;
  final String password;
  final String? phone;
  final File? image;

  Map<String, dynamic> toMap() => {
        'nickname': nickname,
        'email': email,
        'password': password,
        'phone': phone,
      };

  Map<String, dynamic> toMapImage(MultipartFile image) => {
        'nickname': nickname,
        'email': email,
        'password': password,
        'phone': phone,
        'image': image,
      };
}
