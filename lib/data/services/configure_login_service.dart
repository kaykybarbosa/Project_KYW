import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';
import 'package:kyw_management/domain/models/auth_user_model.dart';

abstract class IAuthSettingsService {
  static IAuthSettingsService get instance => Get.find<IAuthSettingsService>();

  /// Realiza algumas configurações quando Candidato realiza login.
  ///
  /// Configurações como:
  ///
  ///- Atualiza os dados de autenticação.
  ///
  ///- Atualiza o valor do primeiro acesso.
  ///
  ///- Atualiza os dados de autorização.
  ///
  ///- Atualiza as informações do usuário autenticado.
  ///
  Future<void> login({
    required AuthUserModel authUser,
    required CurrentUserModel currentUserModel,
  });
}

class AuthSettingsService implements IAuthSettingsService {
  AuthSettingsService() : appController = AppController.instance;

  late final AppController appController;

  @override
  Future<void> login({
    required AuthUserModel authUser,
    required CurrentUserModel currentUserModel,
  }) async {
    await Future.wait([
      appController.setConfigurations(appController.configureApp.copyWith(
        isFirstAccess: false,
        currentUserIsAuth: true,
      )),
      appController.setAuthenticationUser(authUser),
    ]);
  }
}
