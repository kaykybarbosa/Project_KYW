import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPrefsService {
  static ISharedPrefsService get instance => Get.find<ISharedPrefsService>();

  Future<void> write(String key, String value);

  Future<void> writeList(String key, List<String> value);

  String? read(String key);

  List<String>? readList(String key);

  Future<void> delete(String key);
}

class SharedPrefsService implements ISharedPrefsService {
  SharedPrefsService({required SharedPreferences shared}) : _prefs = shared;

  final SharedPreferences _prefs;

  @override
  String? read(String key) => _prefs.getString(key);

  @override
  List<String>? readList(String key) => _prefs.getStringList(key);

  @override
  Future<void> write(
    String key,
    String value,
  ) async =>
      await _prefs.setString(key, value);

  @override
  Future<void> writeList(
    String key,
    List<String> value,
  ) async =>
      await _prefs.setStringList(key, value);

  @override
  Future<void> delete(String key) async => await _prefs.remove(key);
}
