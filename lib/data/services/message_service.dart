import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/request/message_request.dart';
import 'package:kyw_management/data/repositories/message_repository.dart';
import 'package:kyw_management/data/services/web_socket_client.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:kyw_management/domain/models/message.dart';
import 'package:result_dart/result_dart.dart';

abstract class IMessageService {
  static IMessageService get instance => Get.find<IMessageService>();

  AsyncResult<Unit, ApiException> createMessage(MessageRequest message);

  void subscribeToMessageUpdates(Function(Map<String, dynamic>) onMessageReceived);

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
  AsyncResult<Unit, ApiException> createMessage(MessageRequest message) async {
    try {
      var payload = {'event': 'message.create', 'data': message.toJson()};

      _ws.send(jsonEncode(payload));

      return unit.toSuccess();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  Future<List<Message>> fetchMessages(String chatRoomId) async {
    final result = await _message.getMessages();

    return result.getOrNull() ?? [];
  }

  @override
  void subscribeToMessageUpdates(
    void Function(Map<String, dynamic>) onMessageReceived,
  ) {
    _messageSubscription = _ws.messageUpdates().listen(
      (message) {
        onMessageReceived(message);
      },
    );
  }

  @override
  void unsubscribeFromMessageUpdates() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
  }
}
