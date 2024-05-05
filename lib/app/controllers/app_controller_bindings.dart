import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/storages/configure_app_storage.dart';
import 'package:kyw_management/data/storages/current_user_storage.dart';

class AppControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController(
          configureAppStorage: IConfigureAppStorage.instance,
          currentUserStorage: ICurrentUserStorage.instance,
        ));
  }
}
