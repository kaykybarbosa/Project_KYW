// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ProjectIncludeResponse extends Equatable {
  ProjectIncludeResponse({
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

  factory ProjectIncludeResponse.fromMap(Map<String, dynamic> map) => ProjectIncludeResponse(
        projectId: map['projectId'],
        name: map['name'],
      );

  String toJson() => json.encode(toMap());

  factory ProjectIncludeResponse.fromJson(String source) => ProjectIncludeResponse.fromMap(json.decode(source));
}
