import 'dart:async';
import 'dart:convert';
import '../../logger/app_logger.dart';
import 'websocket_service.dart';

/// Service chuyên xử lý WebSocket cho shipper location tracking
class ShipperLocationSocketService {
  final SocketManager _socketManager;
  static const String _connectionKey = 'shipper_location';
  static const String _baseUrl = 'ws://localhost:8080/ws/shipper-location';
  
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();
  
  StreamSubscription<String>? _websocketSubscription;
  
  ShipperLocationSocketService(this._socketManager);
  
  /// Stream để lắng nghe raw messages từ WebSocket
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
  
  /// Stream để lắng nghe connection status changes từ SocketManager
  Stream<bool>? get connectionStream => _socketManager.connectionStream(_connectionKey);
  
  /// Kiểm tra trạng thái kết nối từ SocketManager
  bool get isConnected => _socketManager.isConnected(_connectionKey);
  
  /// Kết nối đến WebSocket server sử dụng SocketManager
  Future<void> connect() async {
    try {
      AppLogger.d('Connecting to shipper location WebSocket via SocketManager');
      
      // Use SocketManager's connect method - nó đã có async support rồi!
      await _socketManager.connect(_connectionKey, _baseUrl);
      
      // Subscribe to messages từ SocketManager
      _websocketSubscription = _socketManager.listen(_connectionKey)?.listen(
        (message) => _handleRawMessage(message),
        onError: (error) => AppLogger.e('WebSocket message error', error),
      );
      
      AppLogger.i('Successfully connected to shipper location WebSocket');
    } catch (e) {
      AppLogger.e('Failed to connect to WebSocket', e);
      rethrow;
    }
  }
  
  /// Ngắt kết nối
  Future<void> disconnect() async {
    try {
      AppLogger.d('Disconnecting shipper location WebSocket');
      
      await _websocketSubscription?.cancel();
      _websocketSubscription = null;
      
      _socketManager.disconnect(_connectionKey);
      
      AppLogger.i('Disconnected from shipper location WebSocket');
    } catch (e) {
      AppLogger.e('Error disconnecting WebSocket', e);
      throw Exception('Failed to disconnect: ${e.toString()}');
    }
  }
  
  /// Gửi message để subscribe shipper
  void subscribeToShipper(int shipperId) {
    if (!isConnected) {
      throw Exception('Not connected to WebSocket server');
    }
    
    final message = {
      'action': 'subscribe',
      'shipperId': shipperId,
      'timestamp': DateTime.now().toIso8601String(),
    };
    
    _socketManager.sendJson(_connectionKey, message);
    AppLogger.d('Sent subscribe message for shipper: $shipperId');
  }
  
  /// Gửi message để unsubscribe shipper
  void unsubscribeFromShipper(int shipperId) {
    if (!isConnected) {
      return; // Không throw error nếu đã disconnect
    }
    
    final message = {
      'action': 'unsubscribe',
      'shipperId': shipperId,
      'timestamp': DateTime.now().toIso8601String(),
    };
    
    _socketManager.sendJson(_connectionKey, message);
    AppLogger.d('Sent unsubscribe message for shipper: $shipperId');
  }
  
  /// Xử lý raw WebSocket messages
  void _handleRawMessage(String message) {
    try {
      AppLogger.d('Received WebSocket message: $message');
      
      final data = jsonDecode(message) as Map<String, dynamic>;
      
      // Chỉ emit raw data, không parse thành entity
      _messageController.add(data);
    } catch (e) {
      AppLogger.e('Error parsing WebSocket message', e);
    }
  }
  
  /// Dispose resources
  void dispose() {
    _websocketSubscription?.cancel();
    _messageController.close();
  }
}
