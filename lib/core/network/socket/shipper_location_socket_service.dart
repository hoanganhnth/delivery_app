import 'dart:async';
import 'dart:convert';
import '../../logger/app_logger.dart';
import 'websocket_service.dart';

/// Service chuyên xử lý WebSocket cho shipper location tracking
/// Không quản lý StreamController - chỉ transform/filter stream từ SocketManager
class ShipperLocationSocketService {
  final SocketManager _socketManager;
  static const String _connectionKey = 'shipper_location';
  static const String _baseUrl = 'ws://localhost:8080/ws/shipper-location';
  
  ShipperLocationSocketService(this._socketManager);
  
  /// Stream để lắng nghe raw messages từ WebSocket - transform từ SocketManager
  Stream<Map<String, dynamic>> get messageStream {
    return _socketManager.listen(_connectionKey)
        ?.map((message) => _transformMessage(message))
        .where((data) => data.isNotEmpty) ??
        const Stream.empty();
  }
  
  /// Stream để lắng nghe connection status changes từ SocketManager
  Stream<bool>? get connectionStream => _socketManager.connectionStream(_connectionKey);
  
  /// Kiểm tra trạng thái kết nối từ SocketManager
  bool get isConnected => _socketManager.isConnected(_connectionKey);
  
  /// Kết nối đến WebSocket server sử dụng SocketManager
  /// SocketManager sẽ quản lý StreamController và lifecycle
  Future<void> connect() async {
    try {
      AppLogger.d('Connecting to shipper location WebSocket via SocketManager');
      
      // SocketManager quản lý toàn bộ connection và stream
      await _socketManager.connect(_connectionKey, _baseUrl);
      
      AppLogger.i('Successfully connected to shipper location WebSocket');
    } catch (e) {
      AppLogger.e('Failed to connect to WebSocket', e);
      rethrow;
    }
  }
  
  /// Ngắt kết nối - SocketManager sẽ quản lý cleanup
  Future<void> disconnect() async {
    try {
      AppLogger.d('Disconnecting shipper location WebSocket');
      
      // SocketManager tự cleanup StreamController và connections
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
  
  /// Transform raw WebSocket message to JSON data
  Map<String, dynamic> _transformMessage(String message) {
    try {
      AppLogger.d('Transforming WebSocket message: $message');
      
      final data = jsonDecode(message) as Map<String, dynamic>;
      return data;
    } catch (e) {
      AppLogger.e('Error parsing WebSocket message', e);
      return <String, dynamic>{}; // Return empty map on error
    }
  }
  
  /// No dispose needed - SocketManager handles cleanup
  void dispose() {
    // SocketManager tự quản lý cleanup
    AppLogger.d('ShipperLocationSocketService dispose - cleanup handled by SocketManager');
  }
}
