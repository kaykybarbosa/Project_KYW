// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/project_include_reponse.dart';
import 'package:kyw_management/data/dtos/user_include_response.dart';
import 'package:kyw_management/utils/formaters.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MessageModel extends Equatable {
  MessageModel({
    this.id = 0,
    this.currentUserId = '',
    this.messageId = '',
    UserIncludeResponse? sender,
    ProjectIncludeResponse? project,
    this.content = '',
    DateTime? sentIn,
  })  : sender = ToOne(target: sender),
        project = ToOne(target: project),
        sentIn = sentIn ?? DateTime.now();

  int id;
  String currentUserId;
  String messageId;
  ToOne<UserIncludeResponse> sender;
  ToOne<ProjectIncludeResponse> project;
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

  UserIncludeResponse get getSender => sender.target ?? UserIncludeResponse();

  bool get isSender => currentUserId == AppController.instance.currentUser.id;

  String get hourSentIn => Formatters.formatDateHours(sentIn);

  MessageModel copyWith({
    int? id,
    String? currentUserId,
    String? messageId,
    UserIncludeResponse? sender,
    ProjectIncludeResponse? project,
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
        sender: UserIncludeResponse.fromMap(map['sender']),
        project: ProjectIncludeResponse.fromMap(map['project']),
        content: map['content'],
        sentIn: DateTime.tryParse(map['sentIn']),
      );

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}
