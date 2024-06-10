import 'dart:convert';

import 'package:kyw_management/data/dtos/user_include_response.dart';

class CreateTaskRequest {
  final String title;
  final String criticality;
  final String deadline;
  final String description;
  final String attachments;
  final String completedAt;
  final List<UserIncludeResponse> attributedTo;

  CreateTaskRequest({
    this.title = '',
    this.criticality = '',
    this.deadline = '',
    this.description = '',
    this.attachments = '',
    this.completedAt = '',
    this.attributedTo = const [],
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'criticality': criticality,
        'deadline': deadline,
        'description': description,
        'attachments': attachments,
        'completedAt': completedAt,
        'attributedTo': attributedTo,
      };

  String toJson() => json.encode(toMap());
}
