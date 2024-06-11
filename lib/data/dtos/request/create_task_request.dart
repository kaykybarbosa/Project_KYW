import 'dart:convert';

import 'package:kyw_management/data/dtos/user_include_response.dart';
import 'package:kyw_management/domain/enums/criticality_enum.dart';

class CreateTaskRequest {
  final String title;
  final String criticality;
  final String deadline;
  final String description;
  final String attachments;
  final String projectId;
  final String completedAt;
  final List<UserIncludeResponse> attributedTo;

  CreateTaskRequest({
    this.title = '',
    this.criticality = '',
    this.deadline = '',
    this.description = '',
    this.attachments = '',
    this.projectId = '',
    this.completedAt = '',
    this.attributedTo = const [],
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'criticality': CriticalityEnumM.toLabel(criticality),
        'deadline': deadline,
        'description': description,
        'attachments': attachments,
        'projectId': projectId,
        'attributedTo': attributedTo,
      };

  String toJson() => json.encode(toMap());
}
