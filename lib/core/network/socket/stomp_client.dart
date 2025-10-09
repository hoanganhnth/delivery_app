import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:rxdart/rxdart.dart';
import '../../logger/app_logger.dart';

/// Base STOMP client - mỗi instance quản lý 1 URL duy nhất
class StompSocketClient {
  final String url;
  final String _name;
  final String? username;
  final String? password;

  StompClient? _client;
  final _rawStream = PublishSubject<Map<String, dynamic>>();
  final _connectionStream = BehaviorSubject<bool>.seeded(false);
  Timer? _reconnectTimer;
  bool _isDisposed = false;
  Completer<void>? _connectionCompleter;
  final Map<String, Function()> _subscriptions = {};

  StompSocketClient(
    this.url, {
    String? name,
    this.username,
    this.password,
  }) : _name = name ?? 'STOMP';

  /// Stream raw messages từ STOMP
  Stream<Map<String, dynamic>> get rawStream => _rawStream.stream;

  /// Stream connection status
  Stream<bool> get connectionStream => _connectionStream.stream;

  /// Check connection status
  bool get isConnected => _connectionStream.valueOrNull ?? false;

  /// Kết nối đến STOMP server
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
      _client = StompClient(
        config: StompConfig(
          url: url,
          onConnect: (frame) {
            AppLogger.i('$_name [$url] Kết nối thành công');
            _setConnectionState(true);
            _connectionCompleter?.complete();
            _onConnected();
          },
          onDisconnect: (frame) {
            AppLogger.w('$_name [$url] Ngắt kết nối');
            _setConnectionState(false);
            if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
              _connectionCompleter!.completeError('STOMP disconnected');
            }
            _scheduleReconnect();
          },
          onStompError: (frame) {
            AppLogger.e('$_name [$url] STOMP Error: ${frame.body}');
            _setConnectionState(false);
            if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
              _connectionCompleter!.completeError('STOMP error: ${frame.body}');
            }
            _scheduleReconnect();
          },
          onWebSocketError: (error) {
            AppLogger.e('$_name [$url] WebSocket Error', error);
            _setConnectionState(false);
            if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
              _connectionCompleter!.completeError(error);
            }
            _scheduleReconnect();
          },
          stompConnectHeaders: {
            if (username != null) 'login': username!,
            if (password != null) 'passcode': password!,
          },
        ),
      );

      _setConnectionState(false);
      _client!.activate();

      // Wait for connection to be confirmed or timeout
      await _connectionCompleter!.future.timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          _setConnectionState(false);
          throw Exception('$_name connection timeout after 15 seconds');
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

  /// Subscribe to topic
  void subscribe(String topic, {Function(StompFrame)? onMessage}) {
    if (_client == null || !isConnected) {
      AppLogger.w('$_name [$url] chưa kết nối, không subscribe được $topic');
      return;
    }

    if (_subscriptions.containsKey(topic)) {
      AppLogger.w('$_name [$url] đã subscribe $topic trước đó');
      return;
    }

    AppLogger.d('$_name [$url] Subscribe: $topic');

    final unsubscribe = _client!.subscribe(
      destination: topic,
      callback: (frame) {
        AppLogger.d('$_name [$url] Nhận từ $topic: ${frame.body}');

        final data = {
          'topic': topic,
          'body': frame.body,
          'headers': frame.headers,
        };

        if (!_rawStream.isClosed) {
          _rawStream.add(data);
        }

        onMessage?.call(frame);
      },
    );

    _subscriptions[topic] = unsubscribe;
  }

  /// Unsubscribe from topic
  void unsubscribe(String topic) {
    final unsubscribeCallback = _subscriptions[topic];
    if (unsubscribeCallback != null) {
      AppLogger.d('$_name [$url] Unsubscribe: $topic');
      unsubscribeCallback();
      _subscriptions.remove(topic);
    }
  }

  /// Send message to topic
  void send(String destination, String message, {Map<String, String>? headers}) {
    if (_client != null && isConnected) {
      AppLogger.d('$_name [$url] Gửi đến $destination: $message');
      _client!.send(destination: destination, body: message, headers: headers);
    } else {
      AppLogger.w('$_name [$url] Chưa kết nối, không gửi được');
    }
  }

  /// Send JSON message
  void sendJson(String destination, Map<String, dynamic> data, {Map<String, String>? headers}) {
    send(destination, jsonEncode(data), headers: headers);
  }

  /// Ngắt kết nối
  Future<void> disconnect() async {
    AppLogger.i('$_name [$url] Disconnecting...');

    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    // Unsubscribe all topics
    _subscriptions.keys.toList().forEach(unsubscribe);

    _client?.deactivate();
    _client = null;

    _setConnectionState(false);
    AppLogger.i('$_name [$url] Đã ngắt kết nối');
  }

  /// Dispose toàn bộ resources
  void dispose() {
    if (_isDisposed) return;

    AppLogger.d('$_name [$url] Disposing...');
    _isDisposed = true;

    _reconnectTimer?.cancel();
    _subscriptions.keys.toList().forEach(unsubscribe);
    _client?.deactivate();

    _rawStream.close();
    _connectionStream.close();

    AppLogger.d('$_name [$url] Disposed');
  }

  /// Get active subscriptions
  List<String> get activeSubscriptions => _subscriptions.keys.toList();

  /// Callback sau khi kết nối thành công
  void _onConnected() {
    // Override in subclass if needed
  }

  /// Set connection state
  void _setConnectionState(bool connected) {
    if (!_connectionStream.isClosed && _connectionStream.valueOrNull != connected) {
      _connectionStream.add(connected);
      AppLogger.d('$_name [$url] Connection state: $connected');
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
