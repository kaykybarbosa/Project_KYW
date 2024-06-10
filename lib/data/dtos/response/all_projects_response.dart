import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/user_include_response.dart';

class AllProjectsResponse {
  AllProjectsResponse({
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.projects,
  });

  final int totalPages;
  final int totalElements;
  final int size;
  final List<ProjectResponse> projects;

  factory AllProjectsResponse.fromMap(Map<String, dynamic> map) => AllProjectsResponse(
        totalPages: map['totalPages'],
        totalElements: map['totalElements'],
        size: map['size'],
        projects: map['projects'].isNotEmpty
            ? map['projects'].map<ProjectResponse>((e) => ProjectResponse.fromMap(e)).toList()
            : [],
      );

  static AllProjectsResponse get empty => AllProjectsResponse(
        totalPages: 0,
        totalElements: 0,
        size: 0,
        projects: [],
      );
}

class ProjectResponse extends Equatable {
  const ProjectResponse({
    required this.id,
    required this.name,
    this.description,
    this.creator,
    this.imageUrl,
    this.linkGroup,
    required this.pin,
    required this.createAt,
  });

  final String id;
  final String name;
  final String? description;
  final UserIncludeResponse? creator;
  final String? imageUrl;
  final String? linkGroup;
  final bool pin;
  final DateTime createAt;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        creator,
        imageUrl,
        linkGroup,
        pin,
        createAt,
      ];

  factory ProjectResponse.fromMap(Map<String, dynamic> map) => ProjectResponse(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        creator: map['creator'] != null ? UserIncludeResponse.fromMap(map['creator']) : null,
        imageUrl: map['imageUrl'],
        linkGroup: map['linkGroup'],
        pin: map['pin'],
        createAt: DateTime.parse(map['createAt']),
      );

  factory ProjectResponse.empty() => ProjectResponse(
        id: 'id',
        name: 'name',
        description: 'description',
        creator: UserIncludeResponse(),
        pin: false,
        createAt: DateTime(0000),
      );

  factory ProjectResponse.fromJson(String source) => ProjectResponse.fromMap(json.decode(source));
}
