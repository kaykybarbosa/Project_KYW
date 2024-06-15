import 'package:get/get.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';

class HttpServiceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHttpService>(
      () => HttpService(),
      fenix: true,
    );
    Get.lazyPut<IHttpService>(
      () => HttpService.auth(),
      tag: IHttpService.AUTH_TAG,
      fenix: true,
    );
  }
}
