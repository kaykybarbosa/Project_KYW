import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/services/storage_service/security_storage_service.dart';
import 'package:kyw_management/data/services/storage_service/shared_prefs_service.dart';
import 'package:kyw_management/data/storages/configure_app_storage.dart';
import 'package:kyw_management/data/storages/current_user_storage.dart';
import 'package:kyw_management/data/storages/db/database.dart';
import 'package:kyw_management/data/storages/message_store.dart';

class StoragesBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ICurrentUserStorage>(CurrentUserStorage(storageService: ISecurityStorageService.instance));
    Get.put<IConfigureAppStorage>(ConfigureAppStorage(sharedPrefsService: ISharedPrefsService.instance));
    Get.put<IMessageStore>(MessageStore(IDatabase.instance, AppController.instance));
  }
}
