import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:rxdart/rxdart.dart';
import '../../logger/app_logger.dart';

/// Base WebSocket client - mỗi instance quản lý 1 URL duy nhất
class SocketClient {
  final String url;
  final String _name;
  
  WebSocketChannel? _channel;
  final _rawStream = PublishSubject<String>();
  final _connectionStream = BehaviorSubject<bool>.seeded(false);
  Timer? _reconnectTimer;
  bool _isDisposed = false;
  Completer<void>? _connectionCompleter;

  SocketClient(this.url, {String? name}) : _name = name ?? 'Socket';

  /// Stream raw messages từ WebSocket
  Stream<String> get rawStream => _rawStream.stream;

  /// Stream connection status
  Stream<bool> get connectionStream => _connectionStream.stream;

  /// Check connection status
  bool get isConnected => _connectionStream.valueOrNull ?? false;

  /// Kết nối đến WebSocket
  Future<void> connect() async {
    if (_isDisposed) {
      throw Exception('$_name client has been disposed');
    }

    if (isConnected) {
      AppLogger.w('$_name [$url] đã kết nối rồi');
      return;
    }

    // Check if connection is already in progress
    if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
      AppLogger.d('$_name [$url] Connection already in progress, waiting...');
      return _connectionCompleter!.future;
    }

    AppLogger.i('$_name kết nối → $url');
    _connectionCompleter = Completer<void>();

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _setConnectionState(false);

      // Listen to WebSocket stream
      _channel!.stream.listen(
        (message) {
          AppLogger.d('$_name [$url] Nhận: $message');
          
          // First message confirms connection is ready
          if (!isConnected) {
            _setConnectionState(true);
            _connectionCompleter?.complete();
          }
          
          if (!_rawStream.isClosed) {
            _rawStream.add(message);
          }
        },
        onError: (error) {
          AppLogger.e('$_name [$url] Lỗi', error);
          _setConnectionState(false);
          if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
            _connectionCompleter!.completeError(error);
          }
          _scheduleReconnect();
        },
        onDone: () {
          AppLogger.w('$_name [$url] Kết nối đóng');
          _setConnectionState(false);
          if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
            _connectionCompleter!.completeError('Connection closed unexpectedly');
          }
          _scheduleReconnect();
        },
      );

      // Send ping to test connection
      await _sendPing();

      // Wait for connection confirmation or timeout
      await _connectionCompleter!.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          _setConnectionState(false);
          throw Exception('$_name connection timeout after 10 seconds');
        },
      );

      AppLogger.i('$_name [$url] Successfully connected');
    } catch (e) {
      AppLogger.e('$_name [$url] Không thể kết nối', e);
      _setConnectionState(false);
      _connectionCompleter?.completeError(e);
      _scheduleReconnect();
      rethrow;
    }
  }

  /// Gửi raw message
  void sendRaw(String message) {
    if (_channel != null && isConnected) {
      AppLogger.d('$_name [$url] Gửi: $message');
      _channel!.sink.add(message);
    } else {
      AppLogger.w('$_name [$url] Chưa kết nối, không gửi được');
    }
  }

  /// Gửi JSON message
  void sendJson(Map<String, dynamic> data) {
    sendRaw(jsonEncode(data));
  }

  /// Ngắt kết nối
  Future<void> disconnect() async {
    AppLogger.i('$_name [$url] Disconnecting...');
    
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    
    await _channel?.sink.close(status.normalClosure);
    _channel = null;
    
    _setConnectionState(false);
    AppLogger.i('$_name [$url] Đã ngắt kết nối');
  }

  /// Dispose toàn bộ resources
  void dispose() {
    if (_isDisposed) return;
    
    AppLogger.d('$_name [$url] Disposing...');
    _isDisposed = true;
    
    _reconnectTimer?.cancel();
    _channel?.sink.close(status.normalClosure);
    
    _rawStream.close();
    _connectionStream.close();
    
    AppLogger.d('$_name [$url] Disposed');
  }

  /// Set connection state
  void _setConnectionState(bool connected) {
    if (!_connectionStream.isClosed && _connectionStream.valueOrNull != connected) {
      _connectionStream.add(connected);
      AppLogger.d('$_name [$url] Connection state: $connected');
    }
  }

  /// Send ping message
  Future<void> _sendPing() async {
    try {
      final pingMessage = {
        'action': 'ping',
        'timestamp': DateTime.now().toIso8601String(),
      };
      sendJson(pingMessage);
    } catch (e) {
      AppLogger.e('$_name [$url] Failed to send ping', e);
      throw Exception('Failed to send ping: ${e.toString()}');
    }
  }

  /// Schedule reconnection
  void _scheduleReconnect() {
    if (_isDisposed || _reconnectTimer != null) return;

    AppLogger.i('$_name [$url] Thử reconnect sau 5s...');
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      _reconnectTimer = null;
      if (!_isDisposed) {
        connect().catchError((e) {
          AppLogger.e('$_name [$url] Reconnect failed', e);
        });
      }
    });
  }
}
