import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../logger/app_logger.dart';

/// Quản lý nhiều WebSocket connection
class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  factory SocketManager() => _instance;
  SocketManager._internal();

  final Map<String, WebSocketChannel> _channels = {};
  final Map<String, StreamController<String>> _controllers = {};
  final Map<String, String> _urls = {};
  final Map<String, Timer?> _reconnectTimers = {};

  /// Kết nối đến 1 WebSocket URL
  void connect(String key, String url) {
    if (_channels.containsKey(key)) {
      AppLogger.w('Socket [$key] đã kết nối rồi.');
      return;
    }

    AppLogger.i('Kết nối [$key] → $url');
    _urls[key] = url;

    try {
      final channel = WebSocketChannel.connect(Uri.parse(url));
      _channels[key] = channel;

      // Tạo StreamController để publish message ra ngoài
      final controller = StreamController<String>.broadcast();
      _controllers[key] = controller;

      // Lắng nghe message
      channel.stream.listen(
        (msg) {
          AppLogger.d('[$key] Nhận: $msg');
          controller.add(msg);
        },
        onError: (err) {
          AppLogger.e('[$key] Lỗi', err);
          _scheduleReconnect(key);
        },
        onDone: () {
          AppLogger.w('[$key] Kết nối đóng');
          _scheduleReconnect(key);
        },
      );
    } catch (e) {
      AppLogger.e('[$key] Không thể kết nối', e);
      _scheduleReconnect(key);
    }
  }

  /// Stream để lắng nghe message từ 1 socket
  Stream<String>? listen(String key) => _controllers[key]?.stream;

  /// Gửi message
  void send(String key, String message) {
    final channel = _channels[key];
    if (channel != null) {
      AppLogger.d('[$key] Gửi: $message');
      channel.sink.add(message);
    } else {
      AppLogger.w('[$key] Chưa kết nối, không gửi được');
    }
  }

  /// Ngắt kết nối 1 socket
  void disconnect(String key) {
    _channels[key]?.sink.close(status.normalClosure);
    _channels.remove(key);
    _controllers[key]?.close();
    _controllers.remove(key);
    _reconnectTimers[key]?.cancel();
    _reconnectTimers.remove(key);
    AppLogger.i('[$key] Đã ngắt kết nối');
  }

  /// Ngắt tất cả socket
  void disconnectAll() {
    _channels.keys.toList().forEach(disconnect);
  }

  /// Auto reconnect sau 5s nếu rớt mạng
  void _scheduleReconnect(String key) {
    if (!_urls.containsKey(key)) return;
    if (_reconnectTimers[key] != null) return; // Đã lên lịch rồi

    AppLogger.i('[$key] Thử reconnect sau 5s...');
    _reconnectTimers[key] = Timer(Duration(seconds: 5), () {
      _reconnectTimers[key] = null;
      connect(key, _urls[key]!);
    });
  }
}
