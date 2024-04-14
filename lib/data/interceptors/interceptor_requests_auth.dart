import 'package:dio/dio.dart';

class InterceptorRequestsAuth extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    String message = 'Erro enquanto enviava seus dados!';

    return handler.next(DioException(
      requestOptions: RequestOptions(),
      message: message.isEmpty ? 'Erro enquanto enviava seus dados!' : message,
      response: err.response,
    ));
  }
}
