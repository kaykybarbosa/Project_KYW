import 'dart:io';

import 'package:equatable/equatable.dart';

class CreateProjectRequest extends Equatable {
  const CreateProjectRequest({
    this.image,
    required this.name,
    required this.description,
    this.members = const [],
  });

  final File? image;
  final String name;
  final String description;
  final List<String> members;

  @override
  List<Object?> get props => [
        image,
        name,
        description,
        members,
      ];

  Map<String, dynamic> toMap(String image) => <String, dynamic>{
        'image': image,
        'name': name,
        'description': description,
        'members': members,
      };
}
