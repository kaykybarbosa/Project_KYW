import 'package:get/get.dart';
import 'package:kyw_management/data/repositories/message_repository.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';

class RepositoriesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMessageRepository>(() => MessageRepository(IHttpService.instanceAuth));
    Get.lazyPut<IProjectRepository>(() => ProjectRepository(IHttpService.instanceAuth));
  }
}
