// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/models/user.dart';

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
  List<User> members;
}
