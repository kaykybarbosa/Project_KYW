import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/storages/db/database.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';
import 'package:kyw_management/domain/models/message_model.dart';
import 'package:kyw_management/objectbox.g.dart';

abstract class IMessageStore {
  static IMessageStore get instance => Get.find();

  List<MessageModel> get messages;
}

class MessageStore implements IMessageStore {
  MessageStore(IDatabase database, AppController appController)
      : _db = database,
        _controller = appController;

  final IDatabase _db;
  final AppController _controller;

  CurrentUserModel get _currentUser => _controller.currentUser;

  @override
  List<MessageModel> get messages {
    final box = _db.getBox<MessageModel>();
    final query = box.query(MessageModel_.currentUserId.equals(_currentUser.id)).order(
          MessageModel_.id,
          flags: Order.descending,
        );

    return _db.findQuery(query);
  }
}
