import 'package:get/get.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';

class AuthRepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthRepository>(() => AuthRepository(httpService: IHttpService.instance));
    Get.lazyPut<IAuthRepository>(
      () => AuthRepository(httpService: IHttpService.instanceAuth),
      tag: IAuthRepository.TAG_AUTH,
    );
  }
}
