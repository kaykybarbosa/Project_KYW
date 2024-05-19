import 'package:kyw_management/data/dtos/response/user_response.dart';

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

class ProjectResponse {
  String id;
  String name;
  String description;
  UserResponse creator;
  String? imageUrl;
  String? linkGroup;
  bool pin;
  DateTime createAt;

  ProjectResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.creator,
    this.imageUrl,
    this.linkGroup,
    required this.pin,
    required this.createAt,
  });

  factory ProjectResponse.fromMap(Map<String, dynamic> map) => ProjectResponse(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        creator: UserResponse.fromMap(map['creator']),
        imageUrl: map['imageUrl'],
        linkGroup: map['linkGroup'],
        pin: map['pin'],
        createAt: DateTime.parse(map['createAt']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'creator': creator.toMap(),
        'imageUrl': imageUrl,
        'linkGroup': linkGroup,
        'pin': pin,
        'createAt': createAt.toIso8601String(),
      };

  factory ProjectResponse.empty() => ProjectResponse(
        id: 'id',
        name: 'name',
        description: 'description',
        creator: UserResponse.empty(),
        pin: false,
        createAt: DateTime(0000),
      );
}
