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

    CurrentUserModel? currentUser = appController.currentUser;

    if (currentUser.token.isEmpty) {
      return handler.next(options);
    }

    String token = currentUser.token;

    /// Caso o token esteja inválido, solicitar refresh token
    if (!refreshService.tokenIsValid(token: token)) {
      final response = await refreshService.isAuthenticated(token: token);

      if (response.isSuccess()) {
        response.map((success) async => await refreshService.updateTokens(response: success));

        currentUser = appController.currentUser;

        token = currentUser.token;
      }
    }

    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    String message = 'Erro ao enquanto realizava sua solicitação.';

    if (err.type == DioExceptionType.connectionTimeout) {
      message = 'Ops... não foi possível connectar ao nosso servidor.';
    } else if (err.type == DioExceptionType.connectionError) {
      message = 'Sem conexão com a internet.';
    } else {
      message = err.response?.data['message'] ?? message;
    }

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
