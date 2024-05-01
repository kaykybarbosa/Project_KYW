import 'package:get/get.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository_bindings.dart';
import 'package:kyw_management/data/services/http_service/http_service_bindings.dart';
import 'package:kyw_management/data/services/storage_service/security_storage_service_bindings.dart';
import 'package:kyw_management/data/storages/current_user_storage_bindings.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> dependencyInjections() async {
  await _initSharedPrefs();

  SecurityStorageServiceBindings().dependencies();
  HttpServiceBindings().dependencies();
  AuthRepositoryBindings().dependencies();
  CurrentUserStorageBindings().dependencies();
}

Future<void> _initSharedPrefs() async {
  var sharedPrefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPrefs);
}
