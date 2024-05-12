import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/domain/models/user_test.dart';

class ProjectModel extends Equatable {
  const ProjectModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.lastMessage,
    this.lastMessageTime,
    this.tasks,
    this.users,
    this.inviteLink,
    this.isImportant = false,
  });

  final String id;
  final String name;
  final String? description;
  final String? image;
  final String? lastMessage;
  final String? lastMessageTime;
  final List<Task>? tasks;
  final List<UserTest>? users;
  final String? inviteLink;
  final bool isImportant;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        lastMessage,
        lastMessageTime,
        tasks,
        users,
        inviteLink,
        isImportant,
      ];

  ProjectModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? lastMessage,
    String? lastMessageTime,
    List<Task>? tasks,
    List<UserTest>? users,
    String? inviteLink,
    bool? isImportant,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      tasks: tasks ?? this.tasks,
      users: users ?? this.users,
      inviteLink: inviteLink ?? this.inviteLink,
      isImportant: isImportant ?? this.isImportant,
    );
  }

  String usersToString() {
    String usersString = '';
    if (users != null) {
      for (var user in users!) {
        usersString = '$usersString${user.name}, ';
      }

      var index = usersString.lastIndexOf(',');
      usersString = usersString.replaceRange(index, null, '');
    }

    return usersString;
  }
}
