import 'dart:async';
import 'dart:convert';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/stomp_socket_service.dart';
import '../../../../core/network/socket/websocket_service.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/shipper_location_entity.dart';

/// Service tách biệt để quản lý delivery tracking qua socket
class DeliveryTrackingSocketService {
  static final DeliveryTrackingSocketService _instance = DeliveryTrackingSocketService._internal();
  factory DeliveryTrackingSocketService() => _instance;
  DeliveryTrackingSocketService._internal();

  final StompManager _stompManager = StompManager();
  final SocketManager _socketManager = SocketManager();

  // Stream Controllers
  final StreamController<DeliveryTrackingEntity> _deliveryStreamController =
      StreamController<DeliveryTrackingEntity>.broadcast();
  final StreamController<ShipperLocationEntity> _shipperLocationStreamController =
      StreamController<ShipperLocationEntity>.broadcast();
  final StreamController<bool> _connectionStreamController =
      StreamController<bool>.broadcast();

  // Private state
  bool _isConnected = false;
  int? _currentOrderId;
  StreamSubscription<Map<String, dynamic>>? _stompSubscription;
  StreamSubscription<String>? _webSocketSubscription;

  // Public streams
  Stream<DeliveryTrackingEntity> get deliveryStream => _deliveryStreamController.stream;
  Stream<ShipperLocationEntity> get shipperLocationStream => _shipperLocationStreamController.stream;
  Stream<bool> get connectionStream => _connectionStreamController.stream;

  // Getters
  bool get isConnected => _isConnected;
  int? get currentOrderId => _currentOrderId;

  /// Khởi tạo socket connections
  Future<bool> initialize({
    String stompUrl = 'ws://localhost:61613/stomp',
    String webSocketUrl = 'ws://localhost:3002/location',
    String? username = 'guest',
    String? password = 'guest',
  }) async {
    try {
      AppLogger.i('Initializing delivery tracking socket service...');

      // Kết nối STOMP cho delivery updates
      _stompManager.connect(
        'delivery-tracking',
        stompUrl,
        username: username,
        password: password,
      );

      // Kết nối WebSocket cho shipper location
      _socketManager.connect('shipper-location', webSocketUrl);

      // Setup listeners
      _setupStompListener();
      _setupWebSocketListener();

      // Đợi kết nối thành công
      await _waitForConnection();

      _isConnected = true;
      _connectionStreamController.add(true);
      
      AppLogger.i('Delivery tracking socket service initialized successfully');
      return true;

    } catch (e) {
      AppLogger.e('Failed to initialize delivery tracking socket service', e);
      _isConnected = false;
      _connectionStreamController.add(false);
      return false;
    }
  }

  /// Setup STOMP listener cho delivery updates
  void _setupStompListener() {
    _stompSubscription = _stompManager.listen('delivery-tracking')?.listen(
      (data) {
        try {
          AppLogger.d('STOMP received: ${data['topic']} - ${data['body']}');
          
          // Parse delivery update
          if (data['topic']?.toString().contains('/topic/delivery/') == true) {
            _handleDeliveryUpdate(data['body']?.toString() ?? '');
          }
          
        } catch (e) {
          AppLogger.e('Error processing STOMP message', e);
        }
      },
    );
  }

  /// Setup WebSocket listener cho shipper location
  void _setupWebSocketListener() {
    _webSocketSubscription = _socketManager.listen('shipper-location')?.listen(
      (message) {
        try {
          AppLogger.d('WebSocket received: $message');
          
          // Parse JSON message
          final data = jsonDecode(message) as Map<String, dynamic>;
          
          // Handle location update
          if (data['type'] == 'location') {
            _handleLocationUpdate(data);
          }
          
        } catch (e) {
          AppLogger.e('Error processing WebSocket message', e);
        }
      },
    );
  }

  /// Xử lý delivery update từ STOMP
  void _handleDeliveryUpdate(String rawData) {
    try {
      final data = jsonDecode(rawData) as Map<String, dynamic>;
      
      final deliveryTracking = DeliveryTrackingEntity(
        id: data['id'] ?? 0,
        orderId: data['orderId'] ?? _currentOrderId ?? 0,
        shipperId: data['shipperId'] ?? 0,
        status: data['status'] ?? 'unknown',
        pickupAddress: data['pickupAddress'] ?? '',
        pickupLat: (data['pickupLat'] ?? 0.0).toDouble(),
        pickupLng: (data['pickupLng'] ?? 0.0).toDouble(),
        deliveryAddress: data['deliveryAddress'] ?? '',
        deliveryLat: (data['deliveryLat'] ?? 0.0).toDouble(),
        deliveryLng: (data['deliveryLng'] ?? 0.0).toDouble(),
        shipperCurrentLat: data['shipperCurrentLat']?.toDouble(),
        shipperCurrentLng: data['shipperCurrentLng']?.toDouble(),
        assignedAt: data['assignedAt'] != null
            ? DateTime.parse(data['assignedAt'])
            : null,
        pickedUpAt: data['pickedUpAt'] != null
            ? DateTime.parse(data['pickedUpAt'])
            : null,
        deliveredAt: data['deliveredAt'] != null
            ? DateTime.parse(data['deliveredAt'])
            : null,
        estimatedDeliveryTime: data['estimatedDeliveryTime'] != null
            ? DateTime.parse(data['estimatedDeliveryTime'])
            : null,
        notes: data['notes']?.toString(),
      );

      AppLogger.d('Parsed delivery update: ${deliveryTracking.status}');
      _deliveryStreamController.add(deliveryTracking);

    } catch (e) {
      AppLogger.e('Error parsing delivery update', e);
    }
  }

  /// Xử lý location update từ WebSocket
  void _handleLocationUpdate(Map<String, dynamic> data) {
    try {
      final shipperLocation = ShipperLocationEntity(
        shipperId: data['shipperId'] ?? 0,
        latitude: (data['latitude'] ?? 0.0).toDouble(),
        longitude: (data['longitude'] ?? 0.0).toDouble(),
        updatedAt: data['updatedAt'] != null
            ? DateTime.parse(data['updatedAt'])
            : DateTime.now(),
      );

      AppLogger.d('Parsed location update: ${shipperLocation.latitude}, ${shipperLocation.longitude}');
      _shipperLocationStreamController.add(shipperLocation);

    } catch (e) {
      AppLogger.e('Error parsing location update', e);
    }
  }

  /// Đợi kết nối thành công (timeout 10s)
  Future<void> _waitForConnection() async {
    int attempts = 0;
    const maxAttempts = 50; // 5 seconds with 100ms intervals
    
    while (attempts < maxAttempts) {
      if (_stompManager.isConnected('delivery-tracking')) {
        AppLogger.d('STOMP connection established');
        return;
      }
      
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }
    
    throw Exception('Connection timeout after 5 seconds');
  }

  /// Bắt đầu theo dõi order
  Future<void> startTrackingOrder(int orderId) async {
    try {
      if (!_isConnected) {
        throw Exception('Service chưa được khởi tạo hoặc mất kết nối');
      }

      AppLogger.i('Starting tracking for order $orderId');
      _currentOrderId = orderId;

      // Subscribe STOMP topic cho order này
      _stompManager.subscribe(
        'delivery-tracking',
        '/topic/delivery/$orderId',
      );

      // Subscribe general delivery notifications
      _stompManager.subscribe(
        'delivery-tracking',
        '/topic/notifications',
      );

      // Gửi yêu cầu bắt đầu tracking qua WebSocket
      _socketManager.sendJson('shipper-location', {
        'type': 'start_tracking',
        'orderId': orderId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      // Gửi yêu cầu lấy trạng thái hiện tại qua STOMP
      _stompManager.send(
        'delivery-tracking',
        '/app/delivery/status',
        jsonEncode({
          'orderId': orderId,
          'action': 'get_status',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }),
      );

      AppLogger.i('Successfully started tracking order $orderId');

    } catch (e) {
      AppLogger.e('Failed to start tracking order $orderId', e);
      throw Exception('Không thể bắt đầu theo dõi order: ${e.toString()}');
    }
  }

  /// Dừng theo dõi order
  void stopTrackingOrder() {
    try {
      if (_currentOrderId == null) return;

      AppLogger.i('Stopping tracking for order $_currentOrderId');

      // Unsubscribe STOMP topics
      _stompManager.unsubscribe('delivery-tracking', '/topic/delivery/$_currentOrderId');
      _stompManager.unsubscribe('delivery-tracking', '/topic/notifications');

      // Gửi yêu cầu dừng tracking
      _socketManager.sendJson('shipper-location', {
        'type': 'stop_tracking',
        'orderId': _currentOrderId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      _currentOrderId = null;
      AppLogger.i('Successfully stopped tracking');

    } catch (e) {
      AppLogger.e('Error stopping tracking', e);
    }
  }

  /// Gửi message tùy chỉnh qua STOMP
  void sendStompMessage(String destination, Map<String, dynamic> data) {
    if (!_isConnected) {
      AppLogger.w('Cannot send STOMP message - not connected');
      return;
    }

    _stompManager.send(
      'delivery-tracking',
      destination,
      jsonEncode(data),
    );
  }

  /// Gửi message tùy chỉnh qua WebSocket
  void sendWebSocketMessage(Map<String, dynamic> data) {
    if (!_isConnected) {
      AppLogger.w('Cannot send WebSocket message - not connected');
      return;
    }

    _socketManager.sendJson('shipper-location', data);
  }

  /// Reconnect service
  Future<bool> reconnect() async {
    try {
      AppLogger.i('Reconnecting delivery tracking service...');
      
      await disconnect();
      await Future.delayed(const Duration(milliseconds: 500));
      
      return await initialize();
      
    } catch (e) {
      AppLogger.e('Failed to reconnect service', e);
      return false;
    }
  }

  /// Ngắt kết nối
  Future<void> disconnect() async {
    try {
      AppLogger.i('Disconnecting delivery tracking service...');

      // Stop tracking if active
      if (_currentOrderId != null) {
        stopTrackingOrder();
      }

      // Cancel subscriptions
      await _stompSubscription?.cancel();
      await _webSocketSubscription?.cancel();

      // Disconnect sockets
      _stompManager.disconnect('delivery-tracking');
      _socketManager.disconnect('shipper-location');

      _isConnected = false;
      _connectionStreamController.add(false);
      
      AppLogger.i('Service disconnected successfully');

    } catch (e) {
      AppLogger.e('Error disconnecting service', e);
    }
  }

  /// Dispose service
  void dispose() {
    AppLogger.i('Disposing delivery tracking service...');
    
    disconnect();
    
    // Close stream controllers
    _deliveryStreamController.close();
    _shipperLocationStreamController.close();
    _connectionStreamController.close();
  }

  /// Get connection debug info
  Map<String, dynamic> getDebugInfo() {
    return {
      'isConnected': _isConnected,
      'currentOrderId': _currentOrderId,
      'stompConnected': _stompManager.isConnected('delivery-tracking'),
      'stompConnections': _stompManager.getConnections(),
      'stompSubscriptions': _stompManager.getSubscriptions('delivery-tracking'),
      'hasDeliveryListeners': _deliveryStreamController.hasListener,
      'hasLocationListeners': _shipperLocationStreamController.hasListener,
      'hasConnectionListeners': _connectionStreamController.hasListener,
    };
  }
}
