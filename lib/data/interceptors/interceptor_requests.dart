import 'package:dio/dio.dart';

class InterceptorRequests extends InterceptorsWrapper {
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

    return handler.next(
      DioException(
        requestOptions: RequestOptions(),
        message: message,
        response: err.response,
        error: err.error,
      ),
    );
  }
}
