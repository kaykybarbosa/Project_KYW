import 'package:kyw_management/data/dtos/role_response.dart';

class UserResponse {
  UserResponse({
    required this.id,
    required this.nickname,
    required this.email,
    required this.password,
    this.phone,
    required this.notification,
    required this.state,
    required this.roles,
    required this.assignedTasks,
    required this.projects,
    required this.enabled,
    required this.username,
    required this.authorities,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  String id;
  String nickname;
  String email;
  String password;
  String? phone;
  List<dynamic> notification;
  String state;
  List<RoleResponse> roles;
  List<dynamic> assignedTasks;
  List<dynamic> projects;
  bool enabled;
  String username;
  List<RoleResponse> authorities;
  bool accountNonExpired;
  bool accountNonLocked;
  bool credentialsNonExpired;

  factory UserResponse.fromMap(Map<String, dynamic> map) => UserResponse(
        id: map['id'],
        nickname: map['nickname'],
        email: map['email'],
        password: map['password'],
        phone: map['phone'],
        notification: map['notification'],
        state: map['state'],
        roles: List<RoleResponse>.from(map['roles'].map<RoleResponse>((x) => RoleResponse.fromMap(x))),
        assignedTasks: map['assignedTasks'],
        projects: map['projects'],
        enabled: map['enabled'],
        username: map['username'],
        authorities: List<RoleResponse>.from(map['authorities'].map<RoleResponse>((x) => RoleResponse.fromMap(x))),
        accountNonExpired: map['accountNonExpired'],
        accountNonLocked: map['accountNonLocked'],
        credentialsNonExpired: map['credentialsNonExpired'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nickname': nickname,
        'email': email,
        'password': password,
        'phone': phone,
        'notification': notification,
        'state': state,
        'roles': roles.map((x) => x.toMap()).toList(),
        'assignedTasks': assignedTasks,
        'projects': projects,
        'enabled': enabled,
        'username': username,
        'authorities': authorities.map((x) => x.toMap()).toList(),
        'accountNonExpired': accountNonExpired,
        'accountNonLocked': accountNonLocked,
        'credentialsNonExpired': credentialsNonExpired,
      };
}
