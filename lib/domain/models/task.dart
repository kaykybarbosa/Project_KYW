import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/domain/models/user_test.dart';

class Task {
  Task({
    required this.title,
    this.description,
    this.isImportant = false,
    this.status = TaskStatus.incomplete,
    this.users,
    this.dateOfConclusion,
  });

  String title;
  String? description;
  bool isImportant;
  TaskStatus status;
  List<UserTest>? users;
  DateTime? dateOfConclusion;
}
