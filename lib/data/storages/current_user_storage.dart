import 'package:get/get.dart';
import 'package:kyw_management/data/services/storage_service/security_storage_service.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';

abstract class ICurrentUserStorage {
  static ICurrentUserStorage get instance => Get.find<ICurrentUserStorage>();

  Future<CurrentUserModel?> get currentUser;

  Future<void> write(CurrentUserModel currentUser);

  Future<void> delete();
}

class CurrentUserStorage implements ICurrentUserStorage {
  CurrentUserStorage({required ISecurityStorageService storageService}) : _storage = storageService;

  final String _key = 'CURRENT_USER_KEY';
  final ISecurityStorageService _storage;

  @override
  Future<CurrentUserModel?> get currentUser async {
    var result = await _storage.read(_key);

    if (result != null) {
      return CurrentUserModel.fromJson(result);
    }

    return null;
  }

  @override
  Future<void> write(CurrentUserModel currentUser) async => await _storage.write(
        _key,
        value: currentUser.toJson(),
      );

  @override
  Future<void> delete() async => await _storage.delete(_key);
}
