class RoleResponse {
  String id;
  String authority;

  RoleResponse({
    required this.id,
    required this.authority,
  });

  factory RoleResponse.fromMap(Map<String, dynamic> map) => RoleResponse(
        id: map['id'],
        authority: map['authority'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'authority': authority,
      };
}
