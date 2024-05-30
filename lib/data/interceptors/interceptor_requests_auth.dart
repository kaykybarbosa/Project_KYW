import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/services/refresh_token_service.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';

class InterceptorRequestsAuth extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final appController = AppController.instance;
    final refreshService = IRefreshTokenService.instance;

    CurrentUserModel? currentUser = await appController.currentUser;

    /// Realizar o refresh token se [currentUser] não for null.
    if (currentUser == null) {
      return handler.next(options);
    }

    String? token = currentUser.token;

    /// Caso o token esteja inválido, solicitar refresh token
    if (!refreshService.tokenIsValid(token: token)) {
      final response = await refreshService.isAuthenticated(token: token);

      if (response.isSuccess()) {
        response.map((success) async => await refreshService.updateTokens(response: success));

        currentUser = await appController.currentUser;

        token = currentUser?.token;
      }
    }

    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    String message = 'Erro enquanto enviava seus dados!';

    log(
      'Message: $message, Request: {data: ${err.requestOptions.data}, baseUrl: ${err.requestOptions.baseUrl}}, Response: {data: ${err.response?.data}}',
      name: 'ERROR',
    );

    return handler.next(DioException(
      requestOptions: RequestOptions(),
      message: message.isEmpty ? 'Erro enquanto enviava seus dados!' : message,
      response: err.response,
    ));
  }
}
