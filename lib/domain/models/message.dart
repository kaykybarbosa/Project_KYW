import 'dart:convert';

import 'package:kyw_management/domain/models/project.dart';
import 'package:kyw_management/domain/models/user.dart';

class Message {
  final String id;
  final User sender;
  final Project project;
  final String content;
  final DateTime sentIn;

  Message({
    required this.id,
    required this.sender,
    required this.project,
    required this.content,
    required this.sentIn,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'sender': sender.toMap(),
        'project': project.toMap(),
        'content': content,
        'sentIn': sentIn.millisecondsSinceEpoch,
      };

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        id: map['id'],
        sender: User.fromMap(map['sender']),
        project: Project.fromMap(map['project']),
        content: map['content'],
        sentIn: DateTime.parse(map['sentIn']),
      );

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
