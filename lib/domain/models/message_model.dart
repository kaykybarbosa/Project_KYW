// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/response/user_response.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MessageModel extends Equatable {
  MessageModel({
    this.id = 0,
    this.messageId = '',
    UserResponse? sender,
    ProjectMessage? project,
    this.content = '',
    DateTime? sendIn,
  })  : sender = sender ?? UserResponse(),
        project = project ?? ProjectMessage(),
        sendIn = sendIn ?? DateTime.now();

  int id;
  String messageId;
  UserResponse sender;
  ProjectMessage project;
  String content;
  @Property(type: PropertyType.date)
  DateTime sendIn;

  @override
  List<Object?> get props => [
        id,
        messageId,
        sender,
        project,
        content,
        sendIn,
      ];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': messageId,
        'sender': sender.toMap(),
        'project': project.toMap(),
        'content': content,
        'sendIn': sendIn.toString(),
      };

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
        messageId: map['id'],
        sender: UserResponse.fromMap(map['sender']),
        project: ProjectMessage.fromMap(map['project']),
        content: map['content'],
        sendIn: DateTime.tryParse(map['sendIn']),
      );

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}

@Entity()
class ProjectMessage extends Equatable {
  ProjectMessage({
    this.id = 0,
    this.projectId = '',
    this.name = '',
  });

  int id;
  final String projectId;
  final String name;

  @override
  List<Object?> get props => [id, projectId, name];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'projectId': projectId,
        'name': name,
      };

  factory ProjectMessage.fromMap(Map<String, dynamic> map) => ProjectMessage(
        projectId: map['projectId'],
        name: map['name'],
      );

  String toJson() => json.encode(toMap());

  factory ProjectMessage.fromJson(String source) => ProjectMessage.fromMap(json.decode(source));
}
