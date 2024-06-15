import 'dart:convert';

import 'package:kyw_management/domain/enums/type_notification.dart';

class User {
  User({
    required this.id,
    required this.type,
    required this.content,
    required this.viewed,
    required this.createAt,
  });

  String id;
  TypeNotification type;
  String content;
  bool viewed;
  DateTime createAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'content': content,
        'viewed': viewed,
        'createAt': createAt,
      };

  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        type: map['type'],
        content: map['content'],
        viewed: map['viewed'],
        createAt: DateTime.parse(map['createAt']),
      );

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
