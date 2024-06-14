import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/repositories/message_repository.dart';
import 'package:kyw_management/data/services/configure_login_service.dart';
import 'package:kyw_management/data/services/message_service.dart';
import 'package:kyw_management/data/services/refresh_token_service.dart';
import 'package:kyw_management/data/services/web_socket_client.dart';

class ServicesBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(WebSocketClient());
    Get.put<IMessageService>(
      MessageService(
        messageService: IMessageRepository.instance,
        websocket: WebSocketClient.instance,
      ),
      permanent: true,
    );
    Get.lazyPut<IRefreshTokenService>(
      () => RefreshTokenService(authRepository: IAuthRepository.instance),
      fenix: true,
    );
    Get.lazyPut<IAuthSettingsService>(
      () => AuthSettingsService(AppController.instance),
      fenix: true,
    );
  }
}
