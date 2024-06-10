import 'dart:convert';

import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/project_include_reponse.dart';
import 'package:kyw_management/data/dtos/user_include_response.dart';
import 'package:kyw_management/utils/formaters.dart';

class MessageResponse {
  final String id;
  final UserIncludeResponse sender;
  final ProjectIncludeResponse project;
  final String content;
  final DateTime sentIn;

  MessageResponse({
    required this.id,
    required this.sender,
    required this.project,
    required this.content,
    required this.sentIn,
  });

  bool get isSender => sender.userId == AppController.instance.currentUser.id;

  String get hourSentIn => Formatters.formatDateHours(sentIn);

  Map<String, dynamic> toMap() => {
        'id': id,
        'sender': sender.toMap(),
        'project': project.toMap(),
        'content': content,
        'sentIn': sentIn.millisecondsSinceEpoch,
      };

  factory MessageResponse.fromMap(Map<String, dynamic> map) => MessageResponse(
        id: map['id'],
        sender: UserIncludeResponse.fromMap(map['sender']),
        project: ProjectIncludeResponse.fromMap(map['project']),
        content: map['content'],
        sentIn: DateTime.parse(map['sentIn']),
      );

  String toJson() => json.encode(toMap());

  factory MessageResponse.fromJson(String source) =>
      MessageResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
