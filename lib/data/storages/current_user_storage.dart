import 'package:get/get.dart';
import 'package:kyw_management/data/services/storage_service/security_storage_service.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';
import 'package:kyw_management/domain/models/auth_user_model.dart';

abstract class ICurrentUserStorage {
  static ICurrentUserStorage get instance => Get.find<ICurrentUserStorage>();

  Future<CurrentUserModel?> get currentUser;

  Future<AuthUserModel?> get authUser;

  Future<void> writeCurrentUser(CurrentUserModel currentUser);

  Future<void> writeAuthUser(AuthUserModel authUser);

  Future<void> deleteCurrentUser();

  Future<void> deleteAuthUser();
}

class CurrentUserStorage implements ICurrentUserStorage {
  CurrentUserStorage({required ISecurityStorageService storageService}) : _storage = storageService;

  final String _key = 'CURRENT_USER_KEY';
  final String _authKey = 'AUTH_USER_KEY';
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
  Future<AuthUserModel?> get authUser async {
    var result = await _storage.read(_authKey);

    if (result != null) {
      AuthUserModel.fromJson(result);
    }

    return null;
  }

  @override
  Future<void> writeCurrentUser(CurrentUserModel currentUser) async => await _storage.write(
        _key,
        value: currentUser.toJson(),
      );

  @override
  Future<void> writeAuthUser(AuthUserModel authUser) async => _storage.write(
        _authKey,
        value: authUser.toJson(),
      );

  @override
  Future<void> deleteCurrentUser() async => await _storage.delete(_key);

  @override
  Future<void> deleteAuthUser() async => await _storage.delete(_authKey);
}
