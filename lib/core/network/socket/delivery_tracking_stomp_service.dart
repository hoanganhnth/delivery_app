import 'dart:async';
import 'dart:convert';
import '../../logger/app_logger.dart';
import 'stomp_socket_service.dart';

/// Service chuyên xử lý STOMP cho delivery tracking
/// Không quản lý StreamController - chỉ transform/filter stream từ StompManager
class DeliveryTrackingStompService {
  final StompManager _stompManager;
  static const String _connectionKey = 'delivery_tracking';
  static const String _baseUrl = 'ws://localhost:8085/ws/delivery-native';
  
  // ✅ Track active subscriptions để filter chính xác
  final Set<String> _activeTopics = <String>{};
  
  DeliveryTrackingStompService(this._stompManager);
  
  /// Stream để lắng nghe messages từ delivery topics - filter ngay tại StompManager
  Stream<Map<String, dynamic>> get messageStream {
    // ✅ Filter messages chỉ từ delivery topics với dynamic filtering
    return _stompManager.listen(_connectionKey)
        ?.where((message) {
          final topic = message['topic'] as String?;
          return topic != null && 
                 _activeTopics.contains(topic) &&
                 topic.startsWith('/topic/delivery/');
        })
        .map((message) => _transformMessage(message)) ??
        const Stream.empty();
  }
  
  /// Stream để lắng nghe connection status changes từ StompManager
  Stream<bool>? get connectionStream => _stompManager.connectionStream(_connectionKey);
  
  /// Kiểm tra trạng thái kết nối từ StompManager
  bool get isConnected => _stompManager.isConnected(_connectionKey);
  
  /// Kết nối đến STOMP server sử dụng StompManager
  /// StompManager sẽ quản lý StreamController và lifecycle
  Future<void> connect() async {
    try {
      AppLogger.d('Connecting to delivery tracking STOMP via StompManager');
      
      // StompManager quản lý toàn bộ connection và stream
      await _stompManager.connect(_connectionKey, _baseUrl);
      
      AppLogger.i('Successfully connected to delivery tracking STOMP');
    } catch (e) {
      AppLogger.e('Failed to connect to STOMP', e);
      rethrow;
    }
  }
  
  /// Ngắt kết nối - StompManager sẽ quản lý cleanup
  Future<void> disconnect() async {
    try {
      AppLogger.d('Disconnecting delivery tracking STOMP');
      
      // Clear active topics tracking
      _activeTopics.clear();
      
      // StompManager tự cleanup StreamController và connections
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
    _activeTopics.add(topic);  // ✅ Track active subscription
    AppLogger.d('Subscribed to delivery topic: $topic');
  }
  
  /// Unsubscribe khỏi delivery topic
  void unsubscribeFromOrder(int orderId) {
    if (!isConnected) {
      return; // Không throw error nếu đã disconnect
    }
    
    final topic = '/topic/delivery/$orderId';
    _stompManager.unsubscribe(_connectionKey, topic);
    _activeTopics.remove(topic);  // ✅ Remove from active tracking
    AppLogger.d('Unsubscribed from delivery topic: $topic');
  }
  
  /// Transform raw STOMP message to clean data
  Map<String, dynamic> _transformMessage(Map<String, dynamic> message) {
    try {
      final topic = message['topic'] as String?;
      final body = message['body'] as String?;
      
      if (body != null) {
        AppLogger.d('Transforming STOMP message from topic: $topic');
        
        final data = jsonDecode(body) as Map<String, dynamic>;
        
        // Thêm topic info vào data
        data['_topic'] = topic;
        
        return data;
      }
    } catch (e) {
      AppLogger.e('Error transforming STOMP message', e);
    }
    
    return <String, dynamic>{}; // Return empty map on error
  }
  
  /// No dispose needed - StompManager handles cleanup
  void dispose() {
    // StompManager tự quản lý cleanup
    AppLogger.d('DeliveryTrackingStompService dispose - cleanup handled by StompManager');
  }
}
