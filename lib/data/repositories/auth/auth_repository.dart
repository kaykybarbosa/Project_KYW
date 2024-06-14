// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:kyw_management/data/dtos/request/user_login_request.dart';
import 'package:kyw_management/data/dtos/request/user_register_request.dart';
import 'package:kyw_management/data/dtos/response/refresh_token_response.dart';
import 'package:kyw_management/data/dtos/response/user_response.dart';
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

  AsyncResult<UserResponse, ApiException> getCurrentUser(String userId);
}

class AuthRepository implements IAuthRepository {
  AuthRepository({required IHttpService httpService}) : _http = httpService;

  final IHttpService _http;

  @override
  AsyncResult<CurrentUserModel, ApiException> login(UserLoginRequest request) async {
    try {
      final result = await _http.post(
        '${_http.baseUrl}/auth/signin',
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
      FormData data = FormData();

      if (request.image != null) {
        final image = await MultipartFile.fromFile(request.image!.path);

        data = FormData.fromMap(request.toMapImage(image));
      } else {
        data = FormData.fromMap(request.toMap());
      }

      await _http.post(
        '${_http.baseUrl}/users/register',
        data: data,
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
      final request = {'refreshToken': token};

      final result = await _http.post('${_http.baseUrl}/auth/refreshtoken', data: request);

      return RefreshTokenResponse.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<UserResponse, ApiException> getCurrentUser(String userId) async {
    try {
      final result = await _http.get(
        '${_http.baseUrl}/users/$userId',
      );

      return UserResponse.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }
}
