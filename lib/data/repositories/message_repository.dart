import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/response/message_response.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IMessageRepository {
  static IMessageRepository get instance => Get.find();

  AsyncResult<List<MessageResponse>, ApiException> getMessages(String projectId);
}

class MessageRepository implements IMessageRepository {
  MessageRepository(IHttpService httpService) : _http = httpService;

  final IHttpService _http;

  @override
  AsyncResult<List<MessageResponse>, ApiException> getMessages(String projectId) async {
    try {
      final result = await _http.get('${_http.baseUrl}/messages/project/$projectId?sort=asc');

      final messages = result.data;

      return Success(messages.map<MessageResponse>((m) => MessageResponse.fromMap(m)).toList());
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      log(e.toString(), name: 'TESTERROR');
      return ApiException(message: e.toString()).toFailure();
    }
  }
}
