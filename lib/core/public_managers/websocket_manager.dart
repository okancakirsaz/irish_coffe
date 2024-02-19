import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../init/network_manager.dart';

final class WebSocketManager extends NetworkManager {
  static final WebSocketManager instance = WebSocketManager();

  IO.Socket get socket => IO.io(
      fetchBaseUrl(), IO.OptionBuilder().setTransports(['websocket']).build());
  initializeSocketConnection() {
    try {
      socket.connect();
      socket.onConnect((_) {
        debugPrint("Websocket connection success");
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  disconnectFromSocket() {
    socket.disconnect();
    socket.onDisconnect((data) => debugPrint("Websocket disconnected"));
  }

  void webSocketReceiver(String eventName, Function(dynamic) onEvent) {
    socket.on(eventName, (data) {
      onEvent(data);
    });
  }

  void websSocketEmitter(String eventName, dynamic data) {
    socket.emit(eventName, data);
  }
}
