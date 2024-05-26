import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketClient {
  static WebSocketClient get instance => Get.find();

  IOWebSocketChannel? channel;

  late StreamController<Map<String, dynamic>> messageController;

  WebSocketClient() {
    _initializeControllers();
  }

  void _initializeControllers() {
    messageController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void connect(
    String url,
    Map<String, String> headers,
  ) {
    if (channel != null && channel!.closeCode == null) {
      log('Already connected', name: 'WEBSOCKET');
      return;
    }

    log('Connecting to the server...', name: 'WEBSOCKET');
    channel = IOWebSocketChannel.connect(url, headers: headers);

    channel!.stream.listen(
      (event) {
        Map<String, dynamic> message = jsonDecode(event);

        if (message['event'] == 'message.created') {
          messageController.add(message['data']);
        }
      },
      onDone: () {
        log('Connection closed', name: 'WEBSOCKET');
      },
      onError: (error) {
        log('Error: $error', name: 'WEBSOCKET');
      },
    );
  }

  void send(String data) {
    if (channel == null || channel!.closeCode != null) {
      log('Not connected', name: 'WEBSOCKET');
      return;
    }

    channel!.sink.add(data);
  }

  Stream<Map<String, dynamic>> messageUpdates() => messageController.stream;

  void disconnect() {
    if (channel == null || channel!.closeCode != null) {
      log('Not connected', name: 'WEBSOCKET');
      return;
    }
    channel!.sink.close();

    messageController.close();
    _initializeControllers();
  }
}
