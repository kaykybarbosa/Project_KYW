// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/response/refresh_token_response.dart';
import 'package:kyw_management/data/requests_models/user_login_request.dart';
import 'package:kyw_management/data/requests_models/user_register_request.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IAuthRepository {
  static String get TAG_AUTH => 'TAG_AUTH';

  static IAuthRepository get instance => Get.find<IAuthRepository>();

  static IAuthRepository get instanceAuth => Get.find<IAuthRepository>(tag: TAG_AUTH);

  AsyncResult<CurrentUserModel, ApiException> login(UserLoginRequest request);

  AsyncResult<Unit, ApiException> register(UserRegisterRequest request);

  AsyncResult<RefreshTokenResponse, ApiException> refreshToken(String token);
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
  AsyncResult<RefreshTokenResponse, ApiException> refreshToken(String token) async {
    try {
      var result = await _http.post('${_http.baseUrl}auth/refreshtoken', data: token);

      return RefreshTokenResponse.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }
}
