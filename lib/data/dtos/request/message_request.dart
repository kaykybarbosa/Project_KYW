import 'dart:convert';

class MessageRequest {
  MessageRequest({
    required this.userId,
    required this.message,
  });

  String userId;
  String message;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'userId': userId,
        'content': message,
      };

  String toJson() => json.encode(toMap());
}
