import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/user_include_response.dart';

class AllProjectsResponse {
  AllProjectsResponse({
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.content,
  });

  final int totalPages;
  final int totalElements;
  final int size;
  final List<ProjectResponse> content;

  factory AllProjectsResponse.fromMap(Map<String, dynamic> map) => AllProjectsResponse(
        totalPages: map['totalPages'],
        totalElements: map['totalElements'],
        size: map['size'],
        content: map['content'].isNotEmpty
            ? map['content'].map<ProjectResponse>((e) => ProjectResponse.fromMap(e)).toList()
            : [],
      );

  static AllProjectsResponse get empty => AllProjectsResponse(
        totalPages: 0,
        totalElements: 0,
        size: 0,
        content: [],
      );
}

class ProjectResponse extends Equatable {
  final String id;
  final String title;
  final String projectId;
  final String name;
  final String description;
  final UserIncludeResponse? creator;
  final String? imageUrl;
  final String? linkGroup;
  final bool pin;
  final DateTime createAt;

  const ProjectResponse({
    required this.id,
    required this.title,
    required this.projectId,
    required this.name,
    required this.description,
    this.creator,
    this.imageUrl,
    this.linkGroup,
    required this.pin,
    required this.createAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        projectId,
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
        title: map['title'],
        projectId: map['project']['id'],
        name: map['project']['name'],
        description: map['project']['description'],
        creator: map['project']['creator'] != null ? UserIncludeResponse.fromMap(map['project']['creator']) : null,
        imageUrl: map['project']['imageUrl'],
        linkGroup: map['project']['linkGroup'],
        pin: map['project']['pin'],
        createAt: DateTime.parse(map['project']['createAt']),
      );

  factory ProjectResponse.empty() => ProjectResponse(
        id: 'id',
        title: 'title',
        projectId: 'projectId',
        name: 'name',
        description: 'description',
        creator: UserIncludeResponse(),
        pin: false,
        createAt: DateTime(0000),
      );
}
