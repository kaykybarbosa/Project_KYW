import 'dart:ui';

class MessageModel {
  String userReference;
  String message;
  String dateSend;
  bool isSender;
  Color nameColor;

  MessageModel({
    required this.userReference,
    required this.message,
    required this.dateSend,
    required this.isSender,
    required this.nameColor,
  });
}
