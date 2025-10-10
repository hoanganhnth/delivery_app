import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/stomp_client.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/delivery_status.dart';
import 'delivery_tracking_datasource.dart';

/// Socket implementation của DeliveryTrackingDataSource qua STOMP
class DeliveryTrackingSocketDataSource implements DeliveryTrackingDataSource {
  final StompSocketClient socket;
  
  // Stream cho delivery tracking  
  final _deliverySubject = BehaviorSubject<DeliveryTrackingEntity>();
  final _connectionSubject = BehaviorSubject<bool>.seeded(false);
  
  // Track subscribed orders
  final Set<int> _subscribedOrders = <int>{};
  StreamSubscription? _connectionSubscription;
  bool _isDisposed = false;

  DeliveryTrackingSocketDataSource(this.socket);

  @override
  Stream<DeliveryTrackingEntity> get deliveryStream => _deliverySubject.stream;

  @override
  Stream<DeliveryTrackingEntity> deliveryUpdatesForOrder(int orderId) {
    return _deliverySubject.stream
        .where((delivery) => delivery.orderId == orderId)
        .distinct((a, b) => 
          a.status == b.status && 
          a.estimatedDeliveryTime == b.estimatedDeliveryTime);
  }

  @override
  Stream<bool> get connectionStream => _connectionSubject.stream;

  @override
  bool get isConnected => socket.isConnected;

  @override
  Future<void> connect() async {
    try {
      AppLogger.d('DeliveryTrackingSocketDataSource: Connecting...');
      
      // Lắng nghe connection state changes
      _connectionSubscription?.cancel();
      _connectionSubscription = socket.connectionStream.listen((isConnected) {
        _connectionSubject.add(isConnected);
        
        if (isConnected) {
          // Tự động re-subscribe các orders sau khi reconnect
          _resubscribeToOrders();
        }
      });
      
      await socket.connect();
      
      if (socket.isConnected) {
        // Setup message listener - STOMP không có messageStream
        AppLogger.d('DeliveryTrackingSocketDataSource: Connected successfully');
      }
    } catch (e) {
      AppLogger.e('DeliveryTrackingSocketDataSource: Connect failed: $e');
      rethrow;
    }
  }

  @override
  void subscribeToOrder(int orderId) {
    try {
      AppLogger.d('DeliveryTrackingSocketDataSource: Subscribing to order $orderId');
      
      _subscribedOrders.add(orderId);
      
      socket.subscribe('/topic/delivery/$orderId', onMessage: (frame) {
        _handleDeliveryMessage(frame.body ?? '');
      });
      
      AppLogger.d('DeliveryTrackingSocketDataSource: Subscribed to order $orderId');
    } catch (e) {
      _subscribedOrders.remove(orderId);
      AppLogger.e('DeliveryTrackingSocketDataSource: Subscribe to order $orderId failed: $e');
      rethrow;
    }
  }

  @override
  void unsubscribeFromOrder(int orderId) {
    try {
      AppLogger.d('DeliveryTrackingSocketDataSource: Unsubscribing from order $orderId');
      
      _subscribedOrders.remove(orderId);
      socket.unsubscribe('/topic/delivery/$orderId');
      
      AppLogger.d('DeliveryTrackingSocketDataSource: Unsubscribed from order $orderId');
    } catch (e) {
      AppLogger.e('DeliveryTrackingSocketDataSource: Unsubscribe from order $orderId failed: $e');
      rethrow;
    }
  }

  @override
  Set<int> get subscribedOrders => Set.from(_subscribedOrders);

  @override
  Future<void> disconnect() async {
    AppLogger.d('DeliveryTrackingSocketDataSource: Disconnecting...');
    
    await _connectionSubscription?.cancel();
    
    // Unsubscribe từ tất cả orders
    final orders = _subscribedOrders.toList();
    for (final orderId in orders) {
      unsubscribeFromOrder(orderId);
    }
    
    await socket.disconnect();
  }

  void _handleDeliveryMessage(String message) {
    if (_isDisposed) return;
    
    try {
      final data = jsonDecode(message) as Map<String, dynamic>;
      
      final tracking = DeliveryTrackingEntity(
        id: _toInt(data['id']) ?? 0,
        orderId: _toInt(data['order_id']) ?? 0,
        shipperId: _toInt(data['shipper_id']),
        status: DeliveryStatus.fromValue(data['status']?.toString()) ?? DeliveryStatus.pending,
        pickupAddress: data['pickup_address']?.toString() ?? '',
        pickupLat: _toDouble(data['pickup_lat']) ?? 0.0,
        pickupLng: _toDouble(data['pickup_lng']) ?? 0.0,
        deliveryAddress: data['delivery_address']?.toString() ?? '',
        deliveryLat: _toDouble(data['delivery_lat']) ?? 0.0,
        deliveryLng: _toDouble(data['delivery_lng']) ?? 0.0,
        shipperCurrentLat: _toDouble(data['shipper_current_lat']),
        shipperCurrentLng: _toDouble(data['shipper_current_lng']),
        assignedAt: _toDateTime(data['assigned_at']),
        pickedUpAt: _toDateTime(data['picked_up_at']),
        deliveredAt: _toDateTime(data['delivered_at']),
        estimatedDeliveryTime: _toDateTime(data['estimated_delivery_time']),
        notes: data['notes']?.toString(),
      );

      if (!_deliverySubject.isClosed) {
        _deliverySubject.add(tracking);
      }
      
      AppLogger.d('DeliveryTrackingSocketDataSource: Received delivery update for order ${tracking.orderId}');
    } catch (e) {
      AppLogger.e('DeliveryTrackingSocketDataSource: Failed to parse delivery message: $e');
    }
  }

  /// Tự động re-subscribe các orders sau khi reconnect
  void _resubscribeToOrders() {
    if (_subscribedOrders.isNotEmpty) {
      AppLogger.d('DeliveryTrackingSocketDataSource: Re-subscribing to ${_subscribedOrders.length} orders');
      
      final orderIds = _subscribedOrders.toList();
      _subscribedOrders.clear(); // Clear để subscribeToOrder không duplicate
      
      for (final orderId in orderIds) {
        subscribeToOrder(orderId);
      }
    }
  }

  // Type-safe parsing helpers
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  DateTime? _toDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  @override
  Future<void> close() async {
    await dispose();
  }

  @override
  Future<void> dispose() async {
    if (_isDisposed) return;
    _isDisposed = true;
    
    AppLogger.d('DeliveryTrackingSocketDataSource: Disposing...');
    
    await disconnect();
    
    if (!_deliverySubject.isClosed) {
      await _deliverySubject.close();
    }
    if (!_connectionSubject.isClosed) {
      await _connectionSubject.close();
    }
    
    _subscribedOrders.clear();
  }
}
