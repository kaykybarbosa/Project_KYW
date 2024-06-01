import 'dart:async';

import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/request/message_request.dart';
import 'package:kyw_management/data/dtos/response/message_response.dart';
import 'package:kyw_management/data/repositories/message_repository.dart';
import 'package:kyw_management/data/services/web_socket_client.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IMessageService {
  static IMessageService get instance => Get.find<IMessageService>();

  AsyncResult<Unit, ApiException> sendMessage({
    required String projectId,
    required MessageRequest message,
  });

  void subscribeToMessageUpdates({
    required String projectId,
    required Function(Map<String, dynamic>) onMessageReceived,
  });

  void unsubscribeFromMessageUpdates();
}

class MessageService implements IMessageService {
  MessageService({
    required IMessageRepository messageService,
    required WebSocketClient websocket,
  })  : _message = messageService,
        _ws = websocket;

  final IMessageRepository _message;
  final WebSocketClient _ws;
  StreamSubscription? _messageSubscription;

  @override
  AsyncResult<Unit, ApiException> sendMessage({
    required String projectId,
    required MessageRequest message,
  }) async {
    try {
      _ws.send(
        '/chat/project/$projectId',
        body: message.toJson(),
      );

      return unit.toSuccess();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  Future<List<MessageResponse>> getMessages(String projectId) async {
    final result = await _message.getMessages();

    return result.getOrNull() ?? [];
  }

  @override
  void subscribeToMessageUpdates({
    required String projectId,
    required Function(Map<String, dynamic>) onMessageReceived,
  }) {
    _messageSubscription = _ws.messageUpdates().listen((message) => onMessageReceived(message));

    _ws.subscribe(
      '/project/$projectId',
      callback: (frame) => onMessageReceived({'body': frame.body}),
    );
  }

  @override
  void unsubscribeFromMessageUpdates() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
  }
}
