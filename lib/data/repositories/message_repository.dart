import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/response/message_response.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IMessageRepository {
  static IMessageRepository get instance => Get.find();

  AsyncResult<List<MessageResponse>, ApiException> getMessages({bool isDesc = true});
}

class MessageRepository implements IMessageRepository {
  MessageRepository(IHttpService httpService) : _http = httpService;

  final IHttpService _http;

  @override
  AsyncResult<List<MessageResponse>, ApiException> getMessages({bool isDesc = true}) async {
    try {
      final order = isDesc ? 'desc' : 'asc';

      var result = await _http.get('${_http.baseUrl}/messages/sent/$order');

      final messages = result.data['content'];

      return messages.map((m) => MessageResponse.fromJson(m)).toList().toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }
}
