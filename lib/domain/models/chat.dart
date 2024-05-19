import 'package:kyw_management/domain/models/task.dart';

class Chat {
  Chat({
    required this.imageUri,
    required this.title,
    required this.tasks,
    required this.members,
  });
  String imageUri;
  String title;
  List<Task> tasks;
  List members;
}
