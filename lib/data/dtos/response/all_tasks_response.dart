import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/project_include_reponse.dart';
import 'package:kyw_management/data/dtos/user_include_response.dart';
import 'package:kyw_management/domain/enums/criticality_enum.dart';
import 'package:kyw_management/domain/enums/status.dart';

class AllTasksResponse {
  AllTasksResponse({
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.tasks,
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

  static AllTasksResponse get empty => AllTasksResponse(
        totalPages: 0,
        totalElements: 0,
        size: 0,
        tasks: [],
      );
}

class TaskResponse extends Equatable {
  final String id;
  final TaskStatus status;
  final CriticalityEnum criticality;
  final String description;
  final String? attachments;
  final UserIncludeResponse? attributedTo;
  final ProjectIncludeResponse? project;
  final bool pin;
  final DateTime createAt;

  const TaskResponse({
    required this.id,
    required this.status,
    required this.criticality,
    required this.description,
    this.attachments,
    this.attributedTo,
    required this.pin,
    required this.project,
    required this.createAt,
  });

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
      ];

  factory TaskResponse.fromMap(Map<String, dynamic> map) => TaskResponse(
        id: map['id'],
        status: TaskStatusM.fromMap(map['status']),
        criticality: CriticalityEnumM.fromMap(map['criticality']),
        description: map['description'],
        attachments: map['attachments'],
        createAt: DateTime.parse(map['createAt']),
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
}