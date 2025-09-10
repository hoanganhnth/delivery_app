import 'dart:async';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../logger/app_logger.dart';

/// Quản lý nhiều STOMP connection
class StompManager {
  static final StompManager _instance = StompManager._internal();
  factory StompManager() => _instance;
  StompManager._internal();

  final Map<String, StompClient> _clients = {};
  final Map<String, StreamController<Map<String, dynamic>>> _controllers = {};
  final Map<String, String> _urls = {};
  final Map<String, Timer?> _reconnectTimers = {};
  final Map<String, Map<String, Function()>> _subscriptions = {};

  /// Kết nối đến 1 STOMP URL
  void connect(String key, String url, {String? username, String? password}) {
    if (_clients.containsKey(key)) {
      AppLogger.w('STOMP [$key] đã kết nối rồi.');
      return;
    }

    AppLogger.i('STOMP kết nối [$key] → $url');
    _urls[key] = url;

    try {
      final client = StompClient(
        config: StompConfig(
          url: url,
          onConnect: (frame) {
            AppLogger.i('STOMP [$key] Kết nối thành công');
            _onConnected(key);
          },
          onDisconnect: (frame) {
            AppLogger.w('STOMP [$key] Ngắt kết nối');
            _scheduleReconnect(key);
          },
          onStompError: (frame) {
            AppLogger.e('STOMP [$key] Lỗi: ${frame.body}');
            _scheduleReconnect(key);
          },
          onWebSocketError: (error) {
            AppLogger.e('STOMP [$key] WebSocket lỗi', error);
            _scheduleReconnect(key);
          },
          stompConnectHeaders: {
            if (username != null) 'login': username,
            if (password != null) 'passcode': password,
          },
        ),
      );

      _clients[key] = client;
      
      // Tạo StreamController để publish message ra ngoài
      final controller = StreamController<Map<String, dynamic>>.broadcast();
      _controllers[key] = controller;

      client.activate();
    } catch (e) {
      AppLogger.e('STOMP [$key] Không thể kết nối', e);
      _scheduleReconnect(key);
    }
  }

  /// Callback khi kết nối thành công
  void _onConnected(String key) {
    // Có thể thêm logic sau khi kết nối thành công
    // Ví dụ: subscribe lại các topic đã đăng ký trước đó
  }

  /// Subscribe topic và lắng nghe message
  void subscribe(String key, String topic, {Function(StompFrame)? onMessage}) {
    final client = _clients[key];
    if (client == null || !client.connected) {
      AppLogger.w('STOMP [$key] chưa kết nối, không subscribe được $topic');
      return;
    }

    AppLogger.d('STOMP [$key] Subscribe: $topic');
    
    // Lưu subscription để có thể unsubscribe sau
    _subscriptions[key] ??= {};
    
    final unsubscribe = client.subscribe(
      destination: topic,
      callback: (frame) {
        AppLogger.d('STOMP [$key] Nhận từ $topic: ${frame.body}');
        
        // Parse JSON nếu có thể
        Map<String, dynamic>? data;
        try {
          data = {
            'topic': topic,
            'body': frame.body,
            'headers': frame.headers,
          };
        } catch (e) {
          data = {
            'topic': topic,
            'body': frame.body,
            'headers': frame.headers,
          };
        }

        // Gửi qua StreamController
        _controllers[key]?.add(data);
        
        // Gọi callback nếu có
        onMessage?.call(frame);
      },
    );

    _subscriptions[key]![topic] = unsubscribe;
  }

  /// Unsubscribe topic
  void unsubscribe(String key, String topic) {
    final unsubscribeCallback = _subscriptions[key]?[topic];
    if (unsubscribeCallback != null) {
      AppLogger.d('STOMP [$key] Unsubscribe: $topic');
      unsubscribeCallback();
      _subscriptions[key]?.remove(topic);
    }
  }

  /// Stream để lắng nghe message từ 1 STOMP connection
  Stream<Map<String, dynamic>>? listen(String key) => _controllers[key]?.stream;

  /// Gửi message đến topic
  void send(String key, String destination, String message, {Map<String, String>? headers}) {
    final client = _clients[key];
    if (client != null && client.connected) {
      AppLogger.d('STOMP [$key] Gửi đến $destination: $message');
      client.send(
        destination: destination,
        body: message,
        headers: headers,
      );
    } else {
      AppLogger.w('STOMP [$key] Chưa kết nối, không gửi được');
    }
  }

  /// Ngắt kết nối 1 STOMP client
  void disconnect(String key) {
    // Unsubscribe tất cả topic trước
    final subscriptions = _subscriptions[key];
    if (subscriptions != null) {
      subscriptions.keys.toList().forEach((topic) {
        unsubscribe(key, topic);
      });
    }

    // Ngắt kết nối client
    final client = _clients[key];
    if (client != null) {
      client.deactivate();
      _clients.remove(key);
    }

    // Dọn dẹp resources
    _controllers[key]?.close();
    _controllers.remove(key);
    _subscriptions.remove(key);
    _reconnectTimers[key]?.cancel();
    _reconnectTimers.remove(key);
    
    AppLogger.i('STOMP [$key] Đã ngắt kết nối');
  }

  /// Ngắt tất cả STOMP connections
  void disconnectAll() {
    _clients.keys.toList().forEach(disconnect);
  }

  /// Kiểm tra trạng thái kết nối
  bool isConnected(String key) {
    return _clients[key]?.connected ?? false;
  }

  /// Auto reconnect sau 5s nếu rớt mạng
  void _scheduleReconnect(String key) {
    if (!_urls.containsKey(key)) return;
    if (_reconnectTimers[key] != null) return; // Đã lên lịch rồi

    AppLogger.i('STOMP [$key] Thử reconnect sau 5s...');
    _reconnectTimers[key] = Timer(Duration(seconds: 5), () {
      _reconnectTimers[key] = null;
      // Lấy lại thông tin kết nối cũ nếu có
      connect(key, _urls[key]!);
    });
  }

  /// Lấy danh sách tất cả connections
  List<String> getConnections() {
    return _clients.keys.toList();
  }

  /// Lấy danh sách subscriptions của 1 connection
  List<String> getSubscriptions(String key) {
    return _subscriptions[key]?.keys.toList() ?? [];
  }
}
