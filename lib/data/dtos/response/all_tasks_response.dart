// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/project_include_reponse.dart';
import 'package:kyw_management/data/dtos/user_include_response.dart';
import 'package:kyw_management/domain/enums/criticality_enum.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/utils/formaters.dart';

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
    this.title = '',
    this.description = '',
    this.attachments,
    this.attributedTo = const [],
    this.pin = false,
    this.project,
    this.createAt,
    this.completedAt,
  });

  final String id;
  final TaskStatus status;
  final CriticalityEnum? criticality;
  final String title;
  final String? description;
  final String? attachments;
  final List<UserIncludeResponse> attributedTo;
  final ProjectIncludeResponse? project;
  final bool pin;
  final DateTime? createAt;
  final DateTime? completedAt;

  // GETTERS
  String get createAtWithOptions => Formatters.formatDateWithOptions(createAt ?? DateTime.now());

  @override
  List<Object?> get props => [
        id,
        status,
        criticality,
        title,
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
        criticality: map['criticality'] != null ? CriticalityEnumM.fromMap(map['criticality']) : null,
        title: map['title'],
        description: map['description'],
        attachments: map['attachments'],
        createAt: map['createAt'] != null ? DateTime.parse(map['createAt']) : null,
        completedAt: map['completedAt'] != null ? DateTime.parse(map['completedAt']) : null,
        project: map['project'] != null ? ProjectIncludeResponse.fromMap(map['project']) : null,
        attributedTo: map['attributedTo'].isNotEmpty
            ? map['attributedTo'].map<UserIncludeResponse>((member) => UserIncludeResponse.fromMap(member)).toList()
            : [],
        pin: map['pin'],
      );

  factory TaskResponse.empty() => TaskResponse(
        id: 'id',
        status: TaskStatus.incomplete,
        criticality: CriticalityEnum.high,
        description: 'description',
        attributedTo: const [],
        project: ProjectIncludeResponse(),
        pin: false,
        createAt: DateTime(0000),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'status': '',
        'criticality': CriticalityEnumM.toMap(criticality),
        'title': title,
        'description': description,
        'attachments': attachments,
        'attributedTo': attributedTo.map((member) => member.toMap()),
        'project': project?.toMap(),
        'pin': pin,
        'createAt': createAt?.millisecondsSinceEpoch,
        'completedAt': completedAt?.millisecondsSinceEpoch,
      };

  String toJson() => json.encode(toMap());

  factory TaskResponse.fromJson(String source) => TaskResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
