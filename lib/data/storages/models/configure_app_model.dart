import 'dart:convert';

class ConfigureAppModel {
  ConfigureAppModel({
    required this.currentUserIsAuth,
    required this.isFirstAccess,
  });

  final bool currentUserIsAuth;
  final bool isFirstAccess;

  ConfigureAppModel copyWith({
    bool? currentUserIsAuth,
    bool? isFirstAccess,
  }) =>
      ConfigureAppModel(
        currentUserIsAuth: currentUserIsAuth ?? this.currentUserIsAuth,
        isFirstAccess: isFirstAccess ?? this.isFirstAccess,
      );

  Map<String, dynamic> toMap() => {
        'currentUserIsAuth': currentUserIsAuth,
        'isFirstAccess': isFirstAccess,
      };

  static ConfigureAppModel fromMap(Map<String, dynamic> map) => ConfigureAppModel(
        currentUserIsAuth: map['currentUserIsAuth'],
        isFirstAccess: map['isFirstAccess'],
      );

  String toJson() => json.encode(toMap());

  factory ConfigureAppModel.fromJson(String source) =>
      ConfigureAppModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static ConfigureAppModel empty() => ConfigureAppModel(
        currentUserIsAuth: false,
        isFirstAccess: true,
      );
}
