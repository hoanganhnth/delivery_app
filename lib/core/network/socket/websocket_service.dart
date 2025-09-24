import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../logger/app_logger.dart';

/// Quản lý nhiều WebSocket connection
class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  factory SocketManager() => _instance;
  SocketManager._internal();

  final Map<String, WebSocketChannel> _channels = {};
  final Map<String, StreamController<String>> _controllers = {};
  final Map<String, StreamController<bool>> _connectionControllers = {};
  final Map<String, String> _urls = {};
  final Map<String, Timer?> _reconnectTimers = {};
  final Map<String, bool> _connectionStates = {};
  final Map<String, Completer<void>?> _connectionCompleters = {};

  /// Kết nối đến 1 WebSocket URL với async support
  Future<void> connect(String key, String url) async {
    if (_channels.containsKey(key) & isConnected(key)) {
      AppLogger.w('Socket [$key] đã kết nối rồi.');
      return;
    }

    // Check if connection is already in progress
    if (_connectionCompleters[key] != null && !_connectionCompleters[key]!.isCompleted) {
      AppLogger.d('[$key] Connection already in progress, waiting...');
      return _connectionCompleters[key]!.future;
    }

    AppLogger.i('Kết nối [$key] → $url');
    _urls[key] = url;
    
    // Create completer for this connection
    _connectionCompleters[key] = Completer<void>();

    try {
      final channel = WebSocketChannel.connect(Uri.parse(url));
      _channels[key] = channel;

      // Tạo StreamController để publish message ra ngoài
      final messageController = StreamController<String>.broadcast();
      _controllers[key] = messageController;
      
      // Tạo connection status controller
      final connectionController = StreamController<bool>.broadcast();
      _connectionControllers[key] = connectionController;

      // Set initial connection state
      _setConnectionState(key, false);

      // Lắng nghe message
      channel.stream.listen(
        (msg) {
          AppLogger.d('[$key] Nhận: $msg');
          
          // First message confirms connection is ready
          if (!(_connectionStates[key] ?? false)) {
            _setConnectionState(key, true);
            _connectionCompleters[key]?.complete();
          }
          
          messageController.add(msg);
        },
        onError: (err) {
          AppLogger.e('[$key] Lỗi', err);
          _setConnectionState(key, false);
          if (!_connectionCompleters[key]!.isCompleted) {
            _connectionCompleters[key]!.completeError(err);
          }
          _scheduleReconnect(key);
        },
        onDone: () {
          AppLogger.w('[$key] Kết nối đóng');
          _setConnectionState(key, false);
          if (!_connectionCompleters[key]!.isCompleted) {
            _connectionCompleters[key]!.completeError('Connection closed unexpectedly');
          }
          _scheduleReconnect(key);
        },
      );

      // Send ping to test connection
      await _sendPing(key);
      
      // Wait for connection confirmation or timeout
      await _connectionCompleters[key]!.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          _setConnectionState(key, false);
          throw Exception('Connection timeout after 10 seconds');
        },
      );

      AppLogger.i('[$key] Successfully connected');
    } catch (e) {
      AppLogger.e('[$key] Không thể kết nối', e);
      _setConnectionState(key, false);
      _connectionCompleters[key]?.completeError(e);
      _scheduleReconnect(key);
      rethrow;
    }
  }

  /// Stream để lắng nghe message từ 1 socket
  Stream<String>? listen(String key) => _controllers[key]?.stream;

  /// Gửi message
  void sendRaw(String key, String message) {
    final channel = _channels[key];
    if (channel != null) {
      AppLogger.d('[$key] Gửi: $message');
      channel.sink.add(message);
    } else {
      AppLogger.w('[$key] Chưa kết nối, không gửi được');
    }
  }

  void sendJson(String key, Map<String, dynamic> data) {
    sendRaw(key, jsonEncode(data));
  }

  /// Stream để lắng nghe connection status changes
  Stream<bool>? connectionStream(String key) => _connectionControllers[key]?.stream;
  
  /// Kiểm tra connection status
  bool isConnected(String key) => _connectionStates[key] ?? false;

  /// Ngắt kết nối 1 socket
  void disconnect(String key) {
    _channels[key]?.sink.close(status.normalClosure);
    _channels.remove(key);
    _controllers[key]?.close();
    _controllers.remove(key);
    _connectionControllers[key]?.close();
    _connectionControllers.remove(key);
    _connectionStates.remove(key);
    _connectionCompleters.remove(key);
    _reconnectTimers[key]?.cancel();
    _reconnectTimers.remove(key);
    AppLogger.i('[$key] Đã ngắt kết nối');
  }

  /// Ngắt tất cả socket
  void disconnectAll() {
    _channels.keys.toList().forEach(disconnect);
  }

  /// Set connection state và emit event
  void _setConnectionState(String key, bool connected) {
    if (_connectionStates[key] != connected) {
      _connectionStates[key] = connected;
      _connectionControllers[key]?.add(connected);
      AppLogger.d('[$key] Connection state changed: $connected');
    }
  }
  
  /// Send ping để test connection
  Future<void> _sendPing(String key) async {
    try {
      final pingMessage = {
        'action': 'ping',
        'timestamp': DateTime.now().toIso8601String(),
      };
      
      sendJson(key, pingMessage);
      // AppLogger.d('[$key] Sent ping message');
    } catch (e) {
      AppLogger.e('[$key] Failed to send ping', e);
      throw Exception('Failed to send ping: ${e.toString()}');
    }
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
