import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

abstract class ISecurityStorageService {
  static ISecurityStorageService get instance => Get.find<ISecurityStorageService>();

  Future<void> write(String key, {required String value});

  Future<String?> read(String key);

  Future<void> delete(String key);
}

class SecurityStorageService implements ISecurityStorageService {
  SecurityStorageService() : _androidOptions = const AndroidOptions(encryptedSharedPreferences: true);

  final AndroidOptions _androidOptions;
  late final FlutterSecureStorage _storage = FlutterSecureStorage(aOptions: _androidOptions);

  @override
  Future<String?> read(String key) async => await _storage.read(key: key);

  @override
  Future<void> write(String key, {required String value}) async => await _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) async => await _storage.delete(key: key);
}
