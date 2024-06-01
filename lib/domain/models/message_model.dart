import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/response/user_response.dart';

// ignore: must_be_immutable
class MessageModel extends Equatable {
  String id;
  UserResponse sender;
  ProjectMessage project;
  String content;
  DateTime sendIn;

  MessageModel({
    this.id = '',
    this.sender = const UserResponse(),
    this.project = const ProjectMessage(),
    this.content = '',
    DateTime? sendIn,
  }) : sendIn = sendIn ?? DateTime.now();

  @override
  List<Object?> get props => [
        id,
        sender,
        project,
        content,
        sendIn,
      ];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'sender': sender.toMap(),
        'project': project.toMap(),
        'content': content,
        'sendIn': sendIn.millisecondsSinceEpoch,
      };

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
        id: map['id'],
        sender: UserResponse.fromMap(map['sender']),
        project: ProjectMessage.fromMap(map['project']),
        content: map['content'] as String,
        sendIn: DateTime.tryParse(map['sendIn']),
      );

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProjectMessage extends Equatable {
  const ProjectMessage({
    this.projectId = '',
    this.name = '',
  });

  final String projectId;
  final String name;

  @override
  List<Object?> get props => [projectId, name];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'projectId': projectId,
        'name': name,
      };

  factory ProjectMessage.fromMap(Map<String, dynamic> map) => ProjectMessage(
        projectId: map['projectId'] as String,
        name: map['name'] as String,
      );

  String toJson() => json.encode(toMap());

  factory ProjectMessage.fromJson(String source) => ProjectMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
