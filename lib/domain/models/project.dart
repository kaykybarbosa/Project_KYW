// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:kyw_management/data/dtos/response/message_response.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/domain/models/user.dart';

class Project {
  String id;
  String name;
  String description;
  User creator;
  String imageUrl;
  String linkGroup;
  bool pin;
  DateTime createAt;
  bool deleted;
  List<TaskModel> tasks;
  List<MessageResponse> messages;
  List<User> members;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.creator,
    required this.imageUrl,
    required this.linkGroup,
    required this.pin,
    required this.createAt,
    required this.deleted,
    required this.tasks,
    required this.messages,
    required this.members,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'creator': creator.toMap(),
        'imageUrl': imageUrl,
        'linkGroup': linkGroup,
        'pin': pin,
        'createAt': createAt,
        'deleted': deleted,
        'tasks': tasks.map((x) => x.toMap()).toList(),
        'messages': messages.map((x) => x.toMap()).toList(),
        'members': members.map((x) => x.toMap()).toList(),
      };

  factory Project.fromMap(Map<String, dynamic> map) => Project(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        creator: User.fromMap(map['creator']),
        imageUrl: map['imageUrl'],
        linkGroup: map['linkGroup'],
        pin: map['pin'],
        createAt: DateTime.parse(map['createAt']),
        deleted: map['deleted'],
        tasks: List<TaskModel>.from((map['tasks']).map<TaskModel>((x) => TaskModel.fromMap(x))),
        messages: List<MessageResponse>.from((map['messages']).map<MessageResponse>((x) => MessageResponse.fromMap(x))),
        members: List<User>.from((map['members']).map<User>((x) => User.fromMap(x))),
      );

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);
}
