import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/models/user_test.dart';

class Task {
  Task({
    required this.title,
    this.description,
    this.isImportant = false,
    this.status = Status.incomplete,
    this.users,
    this.dateOfConclusion,
  });

  String title;
  String? description;
  bool isImportant;
  Status status;
  List<UserTest>? users;
  DateTime? dateOfConclusion;
}
