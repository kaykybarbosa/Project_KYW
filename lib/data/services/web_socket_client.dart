import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketClient {
  static WebSocketClient get instance => Get.find();

  StompClient? stompClient;
  late StreamController<Map<String, dynamic>> messageController;

  WebSocketClient() {
    _initializeControllers();
  }

  void _initializeControllers() {
    messageController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void connect(String url, {Map<String, String>? headers, Function(StompFrame)? onConnect}) {
    if (stompClient != null && stompClient!.connected) {
      log('Already connected', name: 'WEBSOCKET');
      return;
    }

    log('Connecting to the server in URL: $url', name: 'WEBSOCKET');

    stompClient = StompClient(
      config: StompConfig(
        url: '$url/connect',
        onConnect: onConnect ?? (_) => log('Connect to the server in URL: $url/connect', name: 'WEBSOCKET'),
        onWebSocketError: (dynamic error) => log(error.toString(), name: 'WEBSOCKET'),
      ),
    );

    stompClient!.activate();
  }

  void send(String destination, {String? body, String? token}) {
    if (!_filter()) return;

    stompClient!.send(
      destination: destination,
      body: body,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  void subscribe(
    String destination, {
    String? token,
    required void Function(StompFrame) callback,
  }) {
    if (!_filter()) return;

    stompClient!.subscribe(
      destination: destination,
      callback: callback,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Stream<Map<String, dynamic>> messageUpdates() => messageController.stream;

  void disconnect() {
    if (!_filter()) return;

    stompClient!.deactivate();

    messageController.close();
    _initializeControllers();
  }

  bool _filter() {
    if (stompClient == null || !stompClient!.connected) {
      log('Not connected', name: 'WEBSOCKET');
      return false;
    }

    return true;
  }
}
