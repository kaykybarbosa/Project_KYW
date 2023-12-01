import 'package:kyw_management/app/enums/status.dart';

class Task {
  Task({
    required this.title,
    this.description,
    this.isImportant = false,
    this.status = Status.incomplete,
  });

  String title;
  String? description;
  bool isImportant;
  Status status;
}
