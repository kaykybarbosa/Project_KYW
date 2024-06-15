import 'package:get/get.dart';
import 'package:kyw_management/data/storages/db/database.dart';
import 'package:kyw_management/data/storages/message_storage/message_storage.dart';

class MessageStorageBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<IMessageStorage>(MessageStorage(IDatabase.instance));
  }
}
