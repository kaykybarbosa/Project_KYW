import 'package:get/get.dart';
import 'package:kyw_management/data/services/storage_service/shared_prefs_service.dart';
import 'package:kyw_management/data/storages/models/configure_app_model.dart';

abstract class IConfigureAppStorage {
  static IConfigureAppStorage get instance => Get.find<IConfigureAppStorage>();

  ConfigureAppModel? get currentUser;

  Future<void> write(ConfigureAppModel configure);

  Future<void> delete();
}

class ConfigureAppStorage implements IConfigureAppStorage {
  ConfigureAppStorage({required ISharedPrefsService sharedPrefsService}) : _storage = sharedPrefsService;

  final String _key = 'CONFIGURE_APP_KEY';
  final ISharedPrefsService _storage;

  @override
  ConfigureAppModel? get currentUser {
    var result = _storage.read(_key);

    if (result != null) {
      ConfigureAppModel.fromJson(result);
    }

    return null;
  }

  @override
  Future<void> write(ConfigureAppModel configure) async => await _storage.write(
        _key,
        configure.toJson(),
      );

  @override
  Future<void> delete() async => await _storage.delete(_key);
}
