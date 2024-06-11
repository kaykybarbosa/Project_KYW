// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/project_include_reponse.dart';
import 'package:kyw_management/data/dtos/user_include_response.dart';
import 'package:kyw_management/domain/enums/criticality_enum.dart';
import 'package:kyw_management/domain/enums/status.dart';

class AllTasksResponse {
  const AllTasksResponse({
    this.totalPages = 0,
    this.totalElements = 0,
    this.size = 0,
    this.tasks = const [],
  });

  final int totalPages;
  final int totalElements;
  final int size;
  final List<TaskResponse> tasks;

  factory AllTasksResponse.fromMap(Map<String, dynamic> map) => AllTasksResponse(
        totalPages: map['totalPages'],
        totalElements: map['totalElements'],
        size: map['size'],
        tasks:
            map['content'].isNotEmpty ? map['content'].map<TaskResponse>((e) => TaskResponse.fromMap(e)).toList() : [],
      );

  static AllTasksResponse get empty => const AllTasksResponse(
        totalPages: 0,
        totalElements: 0,
        size: 0,
        tasks: [],
      );
}

class TaskResponse extends Equatable {
  const TaskResponse({
    this.id = '',
    this.status = TaskStatus.incomplete,
    this.criticality,
    this.description = '',
    this.attachments,
    this.attributedTo,
    this.pin = false,
    this.project,
    this.createAt,
    this.completedAt,
  });

  final String id;
  final TaskStatus status;
  final CriticalityEnum? criticality;
  final String description;
  final String? attachments;
  final UserIncludeResponse? attributedTo;
  final ProjectIncludeResponse? project;
  final bool pin;
  final DateTime? createAt;
  final DateTime? completedAt;

  @override
  List<Object?> get props => [
        id,
        status,
        criticality,
        description,
        attributedTo,
        attachments,
        pin,
        createAt,
        completedAt,
      ];

  factory TaskResponse.fromMap(Map<String, dynamic> map) => TaskResponse(
        id: map['id'],
        status: TaskStatusM.fromMap(map['status']),
        criticality: CriticalityEnumM.fromMap(map['criticality']),
        description: map['description'],
        attachments: map['attachments'],
        createAt: DateTime.parse(map['createAt']),
        completedAt: DateTime.parse(map['completedAt']),
        project: map['project'] != null ? ProjectIncludeResponse.fromMap(map['project']) : null,
        attributedTo: map['attributedTo'] != null ? UserIncludeResponse.fromMap(map['attributedTo']) : null,
        pin: map['pin'],
      );

  factory TaskResponse.empty() => TaskResponse(
        id: 'id',
        status: TaskStatus.incomplete,
        criticality: CriticalityEnum.high,
        description: 'description',
        attributedTo: UserIncludeResponse(),
        project: ProjectIncludeResponse(),
        pin: false,
        createAt: DateTime(0000),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'status': '',
        'criticality': CriticalityEnumM.toMap(criticality),
        'description': description,
        'attachments': attachments,
        'attributedTo': attributedTo?.toMap(),
        'project': project?.toMap(),
        'pin': pin,
        'createAt': createAt?.millisecondsSinceEpoch,
        'completedAt': completedAt?.millisecondsSinceEpoch,
      };

  String toJson() => json.encode(toMap());

  factory TaskResponse.fromJson(String source) => TaskResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
