import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/socket_client.dart';
import '../../domain/entities/shipper_location_entity.dart';

/// DataSource quản lý shipper location tracking qua WebSocket
class ShipperLocationSocketDataSource {
  final SocketClient socket;
  final _subject = BehaviorSubject<ShipperLocationEntity>();
  
  // Track subscribed shippers
  final Set<int> _subscribedShippers = <int>{};
  StreamSubscription? _socketSubscription;
  bool _isDisposed = false;

  ShipperLocationSocketDataSource(this.socket);

  /// Stream location updates
  Stream<ShipperLocationEntity> get locationStream => _subject.stream;

  /// Stream location updates cho shipper cụ thể
  Stream<ShipperLocationEntity> locationUpdatesForShipper(int shipperId) {
    return _subject.stream
        .where((location) => location.shipperId == shipperId)
        .distinct((prev, next) => prev.latitude == next.latitude && prev.longitude == next.longitude)
        .throttleTime(const Duration(milliseconds: 500));
  }

  /// Stream connection status
  Stream<bool> get connectionStream => socket.connectionStream;

  /// Check if connected
  bool get isConnected => socket.isConnected;

  /// Kết nối và lắng nghe location updates
  Future<void> connect() async {
    if (_isDisposed) {
      throw Exception('ShipperLocationSocketDataSource has been disposed');
    }

    try {
      AppLogger.d('ShipperLocationSocketDataSource connecting...');
      
      // Kết nối socket
      await socket.connect();
      
      // Listen to raw messages và transform thành ShipperLocationEntity
      _socketSubscription = socket.rawStream
          .map((rawMessage) => _parseLocationMessage(rawMessage))
          .where((location) => location != null)
          .cast<ShipperLocationEntity>()
          .listen(
            (location) {
              if (!_subject.isClosed) {
                _subject.add(location);
              }
            },
            onError: (error) {
              AppLogger.e('ShipperLocationSocketDataSource stream error', error);
            },
          );

      AppLogger.i('ShipperLocationSocketDataSource connected successfully');
    } catch (e) {
      AppLogger.e('ShipperLocationSocketDataSource failed to connect', e);
      rethrow;
    }
  }

  /// Subscribe to shipper location updates
  void subscribeToShipper(int shipperId) {
    if (!isConnected) {
      throw Exception('Not connected to socket server');
    }

    if (_subscribedShippers.contains(shipperId)) {
      AppLogger.w('Already subscribed to shipper: $shipperId');
      return;
    }

    final message = {
      'action': 'subscribe_shipper',
      'shipperId': shipperId,
      'timestamp': DateTime.now().toIso8601String(),
    };

    socket.sendJson(message);
    _subscribedShippers.add(shipperId);
    AppLogger.d('Subscribed to shipper location: $shipperId');
  }

  /// Unsubscribe from shipper location updates
  void unsubscribeFromShipper(int shipperId) {
    if (!isConnected) {
      return; // Silent fail if not connected
    }

    if (!_subscribedShippers.contains(shipperId)) {
      return; // Already unsubscribed
    }

    final message = {
      'action': 'unsubscribe_shipper',
      'shipperId': shipperId,
      'timestamp': DateTime.now().toIso8601String(),
    };

    socket.sendJson(message);
    _subscribedShippers.remove(shipperId);
    AppLogger.d('Unsubscribed from shipper location: $shipperId');
  }

  /// Get list of subscribed shippers
  Set<int> get subscribedShippers => Set.from(_subscribedShippers);

  /// Ngắt kết nối
  Future<void> disconnect() async {
    AppLogger.d('ShipperLocationSocketDataSource disconnecting...');
    
    // Clear subscriptions
    _subscribedShippers.clear();
    
    // Cancel socket subscription
    await _socketSubscription?.cancel();
    _socketSubscription = null;
    
    // Disconnect socket
    await socket.disconnect();
    
    AppLogger.i('ShipperLocationSocketDataSource disconnected');
  }

  /// Dispose resources
  void dispose() {
    if (_isDisposed) return;
    
    AppLogger.d('ShipperLocationSocketDataSource disposing...');
    _isDisposed = true;
    
    _subscribedShippers.clear();
    _socketSubscription?.cancel();
    _subject.close();
    socket.dispose();
    
    AppLogger.d('ShipperLocationSocketDataSource disposed');
  }

  /// Parse raw WebSocket message to ShipperLocationEntity
  ShipperLocationEntity? _parseLocationMessage(String rawMessage) {
    try {
      final data = jsonDecode(rawMessage) as Map<String, dynamic>;
      
      // Check if this is a location update message
      if (data['type'] != 'location_update') {
        return null;
      }

      return ShipperLocationEntity(
        shipperId: data['shipperId'] ?? 0,
        latitude: (data['lat'] ?? data['latitude'] ?? 0.0).toDouble(),
        longitude: (data['lng'] ?? data['longitude'] ?? 0.0).toDouble(),
        accuracy: data['accuracy']?.toDouble(),
        speed: data['speed']?.toDouble(),
        heading: data['heading']?.toDouble(),
        isOnline: data['isOnline'] ?? true,
        lastPing: data['lastPing'] != null ? DateTime.tryParse(data['lastPing']) : null,
        updatedAt: data['timestamp'] != null ? DateTime.tryParse(data['timestamp']) ?? DateTime.now() : DateTime.now(),
      );
    } catch (e) {
      AppLogger.e('Error parsing location message', e);
      return null;
    }
  }
}
