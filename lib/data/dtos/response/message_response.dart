import 'dart:convert';

import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/response/user_response.dart';
import 'package:kyw_management/domain/models/message_model.dart';
import 'package:kyw_management/utils/formaters.dart';

class MessageResponse {
  final String id;
  final UserResponse sender;
  final ProjectMessage project;
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

  String get hourSentIn => Formaters.formatDateHours(sentIn);

  Map<String, dynamic> toMap() => {
        'id': id,
        'sender': sender.toMap(),
        'project': project.toMap(),
        'content': content,
        'sentIn': sentIn.millisecondsSinceEpoch,
      };

  factory MessageResponse.fromMap(Map<String, dynamic> map) => MessageResponse(
        id: map['id'],
        sender: UserResponse.fromMap(map['sender']),
        project: ProjectMessage.fromMap(map['project']),
        content: map['content'],
        sentIn: DateTime.parse(map['sentIn']),
      );

  String toJson() => json.encode(toMap());

  factory MessageResponse.fromJson(String source) =>
      MessageResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
