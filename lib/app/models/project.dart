import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/models/user.dart';

// ignore: must_be_immutable
class Project extends Equatable {
  @override
  Project({
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

  String name;
  String? description;
  String? image;
  String? lastMessage;
  String? lastMessageTime;
  List<Task>? tasks;
  List<UserTest>? users;
  String? inviteLink;
  bool isImportant;

  @override
  List<Object?> get props => [
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

  Project copyWith({
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
    return Project(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      // 'tasks': tasks.map((x) => x?.toMap()).toList(),
      // 'users': users.map((x) => x?.toMap()).toList(),
      'inviteLink': inviteLink,
      'isImportant': isImportant,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      name: map['name'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      lastMessage: map['lastMessage'] != null ? map['lastMessage'] as String : null,
      lastMessageTime: map['lastMessageTime'] != null ? map['lastMessageTime'] as String : null,
      // tasks: map['tasks'] != null
      //     ? List<Task>.from(
      //         (map['tasks'] as List<int>).map<Task?>(
      //           (x) => Task.fromMap(x as Map<String, dynamic>),
      //         ),
      //       )
      //     : null,
      // users: map['users'] != null
      //     ? List<User>.from(
      //         (map['users'] as List<int>).map<User?>(
      //           (x) => User.fromMap(x as Map<String, dynamic>),
      //         ),
      //       )
      //     : null,
      inviteLink: map['inviteLink'] != null ? map['inviteLink'] as String : null,
      isImportant: map['isImportant'] as bool,
    );
  }
}
