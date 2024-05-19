import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/app/controllers/app_controller_bindings.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository_bindings.dart';
import 'package:kyw_management/data/repositories/repositories_bindings.dart';
import 'package:kyw_management/data/services/http_service/http_service_bindings.dart';
import 'package:kyw_management/data/services/storage_service/storages_service_bindings.dart';
import 'package:kyw_management/data/storages/storages_bindings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> dependencyInjections() async {
  await _initSharedPrefs();

  StoragesServiceBindings().dependencies();
  StoragesBindings().dependencies();

  HttpServiceBindings().dependencies();
  AuthRepositoryBindings().dependencies();
  RepositoriesBindings().dependencies();
  AppControllerBindings().dependencies();

  _configuration();
}

Future<void> _initSharedPrefs() async {
  var sharedPrefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPrefs);
}

Future<void> _configuration() async {
  final directory = await getApplicationDocumentsDirectory();

  AppController.instance.setDirectory(directory);
}
