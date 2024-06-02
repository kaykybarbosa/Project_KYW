// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/response/user_response.dart';
import 'package:kyw_management/utils/formaters.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MessageModel extends Equatable {
  MessageModel({
    this.id = 0,
    this.currentUserId = '',
    this.messageId = '',
    UserResponse? sender,
    ProjectMessage? project,
    this.content = '',
    DateTime? sentIn,
  })  : sender = ToOne(target: sender),
        project = ToOne(target: project),
        sentIn = sentIn ?? DateTime.now();

  int id;
  String currentUserId;
  String messageId;
  ToOne<UserResponse> sender;
  ToOne<ProjectMessage> project;
  String content;
  @Property(type: PropertyType.date)
  DateTime sentIn;

  @override
  List<Object?> get props => [
        id,
        currentUserId,
        messageId,
        sender,
        project,
        content,
        sentIn,
      ];

  // G E T T E R S

  UserResponse get getSender => sender.target ?? UserResponse();

  bool get isSender => currentUserId == AppController.instance.currentUser.id;

  String get hourSentIn => Formaters.formatDateHours(sentIn);

  MessageModel copyWith({
    int? id,
    String? currentUserId,
    String? messageId,
    UserResponse? sender,
    ProjectMessage? project,
    String? content,
    DateTime? sentIn,
  }) {
    return MessageModel(
      id: id ?? this.id,
      currentUserId: currentUserId ?? this.currentUserId,
      messageId: messageId ?? this.messageId,
      sender: sender,
      project: project,
      content: content ?? this.content,
      sentIn: sentIn ?? this.sentIn,
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
        messageId: map['id'],
        sender: UserResponse.fromMap(map['sender']),
        project: ProjectMessage.fromMap(map['project']),
        content: map['content'],
        sentIn: DateTime.tryParse(map['sentIn']),
      );

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
