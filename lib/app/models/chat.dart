import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/models/user_test.dart';

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
  List<UserTest> members;
}
