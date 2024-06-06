import 'package:equatable/equatable.dart';
import 'package:kyw_management/data/dtos/user_include_response.dart';

class DetailProjectResponse extends Equatable {
  const DetailProjectResponse({
    required this.projectId,
    required this.name,
    required this.description,
    required this.creator,
    this.imageUrl,
    this.linkGroup,
    required this.pin,
    required this.createAt,
  });

  final String projectId;
  final String name;
  final String description;
  final UserIncludeResponse creator;
  final String? imageUrl;
  final String? linkGroup;
  final bool pin;
  final DateTime createAt;

  @override
  List<Object?> get props => [
        projectId,
        name,
        description,
        creator,
        imageUrl,
        linkGroup,
        pin,
        createAt,
      ];

  factory DetailProjectResponse.fromMap(Map<String, dynamic> map) => DetailProjectResponse(
        projectId: map['id'],
        name: map['name'],
        description: map['description'],
        creator: UserIncludeResponse.fromMap(map['creator']),
        imageUrl: map['imageUrl'],
        linkGroup: map['linkGroup'],
        pin: map['pin'],
        createAt: DateTime.parse(map['createAt']),
      );

  factory DetailProjectResponse.empty() => DetailProjectResponse(
        projectId: '',
        name: '',
        description: '',
        creator: UserIncludeResponse(),
        pin: false,
        createAt: DateTime.now(),
      );
}
