import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/db/database_bindings.dart';
import 'package:kyw_management/data/repositories/repositories_bindings.dart';
import 'package:kyw_management/data/services/storage_service/storages_service_bindings.dart';
import 'package:kyw_management/data/services/web_socket_client.dart';
import 'package:kyw_management/data/storages/storages_bindings.dart';
import 'package:kyw_management/env/env.dart';
import 'package:kyw_management/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> dependencyInjections() async {
  await _initSharedPrefs();
  await _initStoreToDB();

  DatabaseBindings().dependencies();
  StoragesServiceBindings().dependencies();
  StoragesBindings().dependencies();

  AppControllerBindings().dependencies();
  HttpServiceBindings().dependencies();
  RepositoriesBindings().dependencies();
  ServicesBindings().dependencies();
  AuthRepositoryBindings().dependencies();

  _configuration();
  _initWebSocket();
}

Future<void> _initSharedPrefs() async {
  var sharedPrefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPrefs);
}

Future<void> _configuration() async {
  final directory = await getApplicationDocumentsDirectory();

  AppController.instance.setDirectory(directory);
}

void _initWebSocket() {
  WebSocketClient.instance.connect(Env.WEBSOCKET);
}

Future<void> _initStoreToDB() async {
  final store = await openStore();

  Get.put<Store>(store);
}
