import 'dart:io';

import 'package:get/get.dart';
import 'package:kyw_management/data/storages/configure_app_storage.dart';
import 'package:kyw_management/data/storages/current_user_storage.dart';
import 'package:kyw_management/data/storages/models/configure_app_model.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';
import 'package:kyw_management/domain/enums/app_status.dart';
import 'package:kyw_management/domain/models/auth_user_model.dart';

export 'package:kyw_management/domain/enums/app_status.dart';

class AppController extends GetxController {
  AppController({
    required ICurrentUserStorage currentUserStorage,
    required IConfigureAppStorage configureAppStorage,
  })  : _currentUserStorage = currentUserStorage,
        _configureAppStorage = configureAppStorage;

  /// Instância
  static AppController get instance => Get.find<AppController>();

  // Storages
  final ICurrentUserStorage _currentUserStorage;
  final IConfigureAppStorage _configureAppStorage;

  // Props
  late final Rx<AppStatus> _status;
  late final Directory _directory;
  late final CurrentUserModel? _currentUser;

  // Estados do controller
  @override
  void onInit() {
    super.onInit();
    _status = AppStatus.unauthenticated.obs;

    _initCurrentUser();
  }

  // M É T O D O S

  // -- GETTERS

  AppStatus get status => _status.value;

  Directory get directory => _directory;

  CurrentUserModel? get currentUser => _currentUser;

  ConfigureAppModel get configureApp => _configureAppStorage.configureApp ?? ConfigureAppModel.empty();

  Future<AuthUserModel> get authUser async => await _currentUserStorage.authUser ?? const AuthUserModel();

  // -- SETTERS

  void _initCurrentUser() async {
    await _currentUserStorage.currentUser.then((value) => _currentUser = value);
  }

  /// Atualiza o status do usuário no app.
  void updateStatus(AppStatus status) => _status.value = status;

  /// Atualiza as configurações do App.
  Future<void> setConfigurations(ConfigureAppModel configureApp) async =>
      await _configureAppStorage.write(configureApp);

  /// Atualiza o usuário atual.
  Future<void> setCurrentUser(CurrentUserModel currentUser) async {
    updateStatus(AppStatus.authenticated);

    await _currentUserStorage.writeCurrentUser(currentUser);
  }

  /// Atualiza dados de autenticação do usuário.
  Future<void> setAuthenticationUser(AuthUserModel authUser) async => await _currentUserStorage.writeAuthUser(authUser);

  /// Adicionar o diretório de documentos do usuário.
  void setDirectory(Directory directory) => _directory = directory;
}
