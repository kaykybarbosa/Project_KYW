import 'package:get/get.dart';
import 'package:kyw_management/data/services/storage_service/security_storage_service.dart';
import 'package:kyw_management/data/storages/current_user_storage.dart';

class CurrentUserStorageBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ICurrentUserStorage>(CurrentUserStorage(storageService: ISecurityStorageService.instance));
  }
}
