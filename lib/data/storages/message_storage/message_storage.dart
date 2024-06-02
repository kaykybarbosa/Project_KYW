import 'package:get/get.dart';
import 'package:kyw_management/data/storages/db/database.dart';
import 'package:kyw_management/domain/models/message_model.dart';
import 'package:kyw_management/objectbox.g.dart';

abstract class IMessageStorage {
  static IMessageStorage get instance => Get.find();

  List<MessageModel> getMessages(String projectId, {required String currentUserId});
  void addMessage(MessageModel message);
  void deleteMessage(int id);
  void deleteAllMessage(List<int> ids);
  void cleanMessages();
}

class MessageStorage implements IMessageStorage {
  MessageStorage(IDatabase database) : _db = database;

  final IDatabase _db;

  @override
  List<MessageModel> getMessages(String projectId, {required String currentUserId}) {
    final box = _db.getBox<MessageModel>();

    final query = box.query(MessageModel_.currentUserId.equals(currentUserId));

    final messages = _db.findQuery<MessageModel>(query);

    return messages.where((message) => message.project.target?.projectId == projectId).toList();
  }

  @override
  void addMessage(MessageModel message) => _db.save<MessageModel>(message);

  @override
  void deleteMessage(int id) => _db.delete<MessageModel>(id);

  @override
  void deleteAllMessage(List<int> ids) => _db.deleteMany<MessageModel>(ids);

  @override
  void cleanMessages() => _db.deleteAll<MessageModel>();
}
