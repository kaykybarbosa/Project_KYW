import 'dart:convert';

import 'package:kyw_management/domain/enums/criticality_enum.dart';
import 'package:kyw_management/domain/enums/status.dart';

class Task {
  Task({
    required this.title,
    this.description,
    this.isImportant = false,
    this.status = TaskStatus.incomplete,
    this.users,
    this.dateOfConclusion,
  });

  String title;
  String? description;
  bool isImportant;
  TaskStatus status;
  List? users;
  DateTime? dateOfConclusion;
}

class TaskModel {
  String id;
  TaskStatus status;
  CriticalityEnum criticality;
  String description;
  String attachments;
  DateTime createAt;
  DateTime deadline;
  DateTime completedAt;

  TaskModel({
    required this.id,
    required this.status,
    required this.criticality,
    required this.description,
    required this.attachments,
    required this.createAt,
    required this.deadline,
    required this.completedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'status': status,
        'criticality': criticality,
        'description': description,
        'attachments': attachments,
        'createAt': createAt,
        'deadline': deadline,
        'completedAt': completedAt,
      };

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
        id: map['id'],
        status: map['status'],
        criticality: map['criticality'],
        description: map['description'],
        attachments: map['attachments'],
        createAt: DateTime.parse(map['createAt']),
        deadline: DateTime.parse(map['deadline']),
        completedAt: DateTime.parse(map['completedAt']),
      );

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
