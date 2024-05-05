import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/services/configure_login_service.dart';
import 'package:kyw_management/data/services/refresh_token_service.dart';

class ServicesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthSettingsService>(() => AuthSettingsService(AppController.instance));
    Get.lazyPut<IRefreshTokenService>(() => RefreshTokenService(authRepository: IAuthRepository.instance));
  }
}
