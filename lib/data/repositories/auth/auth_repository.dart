import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kyw_management/data/requests_models/user_login_request.dart';
import 'package:kyw_management/data/requests_models/user_register_request.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:kyw_management/domain/models/current_user_model.dart';
import 'package:kyw_management/domain/models/refresh_token_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class IAuthRepository {
  static IAuthRepository get instance => Get.find<IAuthRepository>();

  AsyncResult<CurrentUserModel, ApiException> login(UserLoginRequest request);

  AsyncResult<Unit, ApiException> register(UserRegisterRequest request);

  AsyncResult<RefreshTokenModel, ApiException> refreshToken(String token);
}

class AuthRepository implements IAuthRepository {
  AuthRepository({required IHttpService httpService}) : _http = httpService;

  final IHttpService _http;

  @override
  AsyncResult<CurrentUserModel, ApiException> login(UserLoginRequest request) async {
    try {
      var result = await _http.post(
        '${_http.baseUrl}auth/signin',
        data: request.toMap(),
      );

      return CurrentUserModel.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<Unit, ApiException> register(UserRegisterRequest request) async {
    try {
      await _http.post(
        '${_http.baseUrl}users/register',
        data: request.toMap(),
      );

      return const Success(unit);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<RefreshTokenModel, ApiException> refreshToken(String token) async {
    try {
      var result = await _http.post('${_http.baseUrl}auth/refreshtoken', data: token);

      return RefreshTokenModel.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }
}
