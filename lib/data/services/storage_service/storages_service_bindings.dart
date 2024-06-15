import 'package:get/get.dart';
import 'package:kyw_management/data/services/storage_service/security_storage_service.dart';
import 'package:kyw_management/data/services/storage_service/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoragesServiceBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ISecurityStorageService>(SecurityStorageService());
    Get.put<ISharedPrefsService>(SharedPrefsService(shared: Get.find<SharedPreferences>()));
  }
}
