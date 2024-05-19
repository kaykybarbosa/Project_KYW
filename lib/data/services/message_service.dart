import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/request/message_request.dart';
import 'package:kyw_management/domain/models/message.dart';
import 'package:kyw_management/env/env.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class IMessageService {
  static IMessageService get instance => Get.find<IMessageService>();

  Future<void> initConnection();

  Future<void> broadcastNotifications({
    required void Function(Message message) onReceive,
  });

  void sendMessage(MessageRequest request);
}

class MessageService implements IMessageService {
  late WebSocketChannel _channel;

  @override
  Future<void> initConnection() async {
    Uri wsUrl = Uri.parse('wss://${Env.BASE_URL}messagens/sent/desc');

    _channel = WebSocketChannel.connect(wsUrl);

    await _channel.ready;
  }

  @override
  Future<void> broadcastNotifications({
    required void Function(Message message) onReceive,
  }) async {
    _channel.stream.listen(
      (event) {
        final message = Message.fromJson(event);
        onReceive(message);
      },
      onError: (_) async {},
      onDone: () async {},
      cancelOnError: true,
    );
  }

  @override
  void sendMessage(MessageRequest request) {
    _channel.sink.add(request.toJson());
  }
}
