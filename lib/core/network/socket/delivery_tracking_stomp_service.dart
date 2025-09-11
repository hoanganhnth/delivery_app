import 'dart:async';
import 'dart:convert';
import '../../logger/app_logger.dart';
import 'stomp_socket_service.dart';

/// Service chuyên xử lý STOMP cho delivery tracking
class DeliveryTrackingStompService {
  final StompManager _stompManager;
  static const String _connectionKey = 'delivery_tracking';
  static const String _baseUrl = 'ws://localhost:8080/ws';
  
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();
  
  StreamSubscription<Map<String, dynamic>>? _stompSubscription;
  
  DeliveryTrackingStompService(this._stompManager);
  
  /// Stream để lắng nghe raw messages từ STOMP
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
  
  /// Stream để lắng nghe connection status changes từ StompManager
  Stream<bool>? get connectionStream => _stompManager.connectionStream(_connectionKey);
  
  /// Kiểm tra trạng thái kết nối từ StompManager
  bool get isConnected => _stompManager.isConnected(_connectionKey);
  
  /// Kết nối đến STOMP server sử dụng StompManager
  Future<void> connect() async {
    try {
      AppLogger.d('Connecting to delivery tracking STOMP via StompManager');
      
      // Use StompManager's async connect method
      await _stompManager.connect(_connectionKey, _baseUrl);
      
      // Subscribe to messages từ StompManager
      _stompSubscription = _stompManager.listen(_connectionKey)?.listen(
        _handleRawMessage,
        onError: (error) => AppLogger.e('STOMP message error', error),
      );
      
      AppLogger.i('Successfully connected to delivery tracking STOMP');
    } catch (e) {
      AppLogger.e('Failed to connect to STOMP', e);
      rethrow;
    }
  }
  
  /// Ngắt kết nối
  Future<void> disconnect() async {
    try {
      AppLogger.d('Disconnecting delivery tracking STOMP');
      
      await _stompSubscription?.cancel();
      _stompSubscription = null;
      
      _stompManager.disconnect(_connectionKey);
      
      AppLogger.i('Disconnected from delivery tracking STOMP');
    } catch (e) {
      AppLogger.e('Error disconnecting STOMP', e);
      throw Exception('Failed to disconnect: ${e.toString()}');
    }
  }
  
  /// Subscribe to delivery topic cho order cụ thể
  void subscribeToOrder(int orderId) {
    if (!isConnected) {
      throw Exception('Not connected to STOMP server');
    }
    
    final topic = '/topic/delivery/$orderId';
    _stompManager.subscribe(_connectionKey, topic);
    AppLogger.d('Subscribed to delivery topic: $topic');
  }
  
  /// Unsubscribe khỏi delivery topic
  void unsubscribeFromOrder(int orderId) {
    if (!isConnected) {
      return; // Không throw error nếu đã disconnect
    }
    
    final topic = '/topic/delivery/$orderId';
    _stompManager.unsubscribe(_connectionKey, topic);
    AppLogger.d('Unsubscribed from delivery topic: $topic');
  }
  
  /// Xử lý raw STOMP messages
  void _handleRawMessage(Map<String, dynamic> message) {
    try {
      final topic = message['topic'] as String?;
      final body = message['body'] as String?;
      
      if (topic?.contains('/topic/delivery/') == true && body != null) {
        AppLogger.d('Received STOMP message from topic: $topic');
        
        final data = jsonDecode(body) as Map<String, dynamic>;
        
        // Thêm topic info vào data
        data['_topic'] = topic;
        
        // Chỉ emit raw data, không parse thành entity
        _messageController.add(data);
      }
    } catch (e) {
      AppLogger.e('Error parsing STOMP message', e);
    }
  }
  
  /// Dispose resources
  void dispose() {
    _stompSubscription?.cancel();
    _messageController.close();
  }
}
