import 'dart:convert';

class ConfigureAppModel {
  ConfigureAppModel({required this.currentUserIsAuth});

  final bool currentUserIsAuth;

  ConfigureAppModel copyWith({bool? currentUserIsAuth}) =>
      ConfigureAppModel(currentUserIsAuth: currentUserIsAuth ?? this.currentUserIsAuth);

  Map<String, dynamic> toMap() => {
        'currentUserIsAuth': currentUserIsAuth,
      };

  static ConfigureAppModel fromMap(Map<String, dynamic> map) => ConfigureAppModel(
        currentUserIsAuth: map['currentUserIsAuth'],
      );

  String toJson() => json.encode(toMap());

  factory ConfigureAppModel.fromJson(String source) =>
      ConfigureAppModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
