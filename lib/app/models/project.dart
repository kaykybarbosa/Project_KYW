import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/models/user.dart';

class Project {
  Project({
    required this.name,
    this.image,
    this.lastMessage,
    this.lastMessageTime,
    this.tasks,
    this.users,
    this.inviteLink,
    this.isImportant = false,
  });

  String name;
  String? image;
  String? lastMessage;
  String? lastMessageTime;
  List<Task>? tasks;
  List<User>? users;
  String? inviteLink;
  bool isImportant;
}
