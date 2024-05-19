import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/response/refresh_token_response.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IRefreshTokenService {
  /// Instância do service.
  static IRefreshTokenService get instance => Get.find<IRefreshTokenService>();

  /// Realizar uma requisição para atualizar o token.
  ///
  /// Retorna [RefreshTokenResponse] com base no [currentUser] recebido.
  AsyncResult<RefreshTokenResponse, Unit> isAuthenticated({required String token});

  /// Atualiza os token do Candidato com base na [response].
  Future<void> updateTokens({required RefreshTokenResponse response});

  /// Informa se o token expirou.
  ///
  /// Retorna true se o token for válido, caso contrário um false.
  ///
  bool tokenIsValid({String? token});
}

class RefreshTokenService implements IRefreshTokenService {
  RefreshTokenService({
    required IAuthRepository authRepository,
  }) : _auth = authRepository;

  final IAuthRepository _auth;

  @override
  AsyncResult<RefreshTokenResponse, Unit> isAuthenticated({required String token}) async {
    var result = await _auth.refreshToken(token);

    return result.fold(
      (success) => success.toSuccess(),
      (failure) => unit.toFailure(),
    );
  }

  @override
  Future<void> updateTokens({required RefreshTokenResponse response}) async {
    var appController = AppController.instance;

    var currentUser = await appController.currentUser;

    if (currentUser != null) {
      await appController.setCurrentUser(
        currentUser.copyWith(
          token: response.token,
          refreshToken: response.refreshToken,
        ),
      );
    }
  }

  @override
  bool tokenIsValid({String? token}) {
    try {
      if (token == null) return false;
      return JwtDecoder.isExpired(token) ? false : true;
    } catch (e) {
      return false;
    }
  }
}
