import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/stomp_client.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/delivery_status.dart';

/// DataSource quản lý delivery tracking qua STOMP
class DeliveryTrackingSocketDataSource {
  final StompSocketClient socket;
  final _subject = BehaviorSubject<DeliveryTrackingEntity>();
  
  // Track subscribed orders
  final Set<int> _subscribedOrders = <int>{};
  StreamSubscription? _socketSubscription;
  bool _isDisposed = false;

  DeliveryTrackingSocketDataSource(this.socket);

  /// Stream delivery tracking updates
  Stream<DeliveryTrackingEntity> get deliveryStream => _subject.stream;

  /// Stream delivery updates cho order cụ thể
  Stream<DeliveryTrackingEntity> deliveryUpdatesForOrder(int orderId) {
    return _subject.stream
        .where((delivery) => delivery.orderId == orderId)
        .distinct((prev, next) => prev.status == next.status)
        .switchMap((data) => Stream.value(data))
        .takeUntil(Stream.fromFuture(Future.delayed(const Duration(hours: 1))));
  }

  /// Stream connection status
  Stream<bool> get connectionStream => socket.connectionStream;

  /// Check if connected
  bool get isConnected => socket.isConnected;

  /// Kết nối và lắng nghe delivery updates
  Future<void> connect() async {
    if (_isDisposed) {
      throw Exception('DeliveryTrackingSocketDataSource has been disposed');
    }

    try {
      AppLogger.d('DeliveryTrackingSocketDataSource connecting...');
      
      // Kết nối STOMP socket
      await socket.connect();
      
      // Listen to raw messages và transform thành DeliveryTrackingEntity
      _socketSubscription = socket.rawStream
          .where((message) {
            final topic = message['topic'] as String?;
            return topic != null && topic.startsWith('/topic/delivery/');
          })
          .map((message) => _parseDeliveryMessage(message))
          .where((delivery) => delivery != null)
          .cast<DeliveryTrackingEntity>()
          .distinct((prev, next) => prev.orderId == next.orderId && prev.status == next.status)
          .debounceTime(const Duration(milliseconds: 200))
          .listen(
            (delivery) {
              if (!_subject.isClosed) {
                _subject.add(delivery);
              }
            },
            onError: (error) {
              AppLogger.e('DeliveryTrackingSocketDataSource stream error', error);
            },
          );

      AppLogger.i('DeliveryTrackingSocketDataSource connected successfully');
    } catch (e) {
      AppLogger.e('DeliveryTrackingSocketDataSource failed to connect', e);
      rethrow;
    }
  }

  /// Subscribe to delivery tracking cho order
  void subscribeToOrder(int orderId) {
    if (!isConnected) {
      throw Exception('Not connected to STOMP server');
    }

    if (_subscribedOrders.contains(orderId)) {
      AppLogger.w('Already subscribed to order: $orderId');
      return;
    }

    final topic = '/topic/delivery/$orderId';
    socket.subscribe(topic);
    _subscribedOrders.add(orderId);
    AppLogger.d('Subscribed to delivery topic: $topic');
  }

  /// Unsubscribe from delivery tracking
  void unsubscribeFromOrder(int orderId) {
    if (!isConnected) {
      return; // Silent fail if not connected
    }

    if (!_subscribedOrders.contains(orderId)) {
      return; // Already unsubscribed
    }

    final topic = '/topic/delivery/$orderId';
    socket.unsubscribe(topic);
    _subscribedOrders.remove(orderId);
    AppLogger.d('Unsubscribed from delivery topic: $topic');
  }

  /// Get list of subscribed orders
  Set<int> get subscribedOrders => Set.from(_subscribedOrders);

  /// Ngắt kết nối
  Future<void> disconnect() async {
    AppLogger.d('DeliveryTrackingSocketDataSource disconnecting...');
    
    // Clear subscriptions
    _subscribedOrders.clear();
    
    // Cancel socket subscription
    await _socketSubscription?.cancel();
    _socketSubscription = null;
    
    // Disconnect socket
    await socket.disconnect();
    
    AppLogger.i('DeliveryTrackingSocketDataSource disconnected');
  }

  /// Dispose resources
  void dispose() {
    if (_isDisposed) return;
    
    AppLogger.d('DeliveryTrackingSocketDataSource disposing...');
    _isDisposed = true;
    
    _subscribedOrders.clear();
    _socketSubscription?.cancel();
    _subject.close();
    socket.dispose();
    
    AppLogger.d('DeliveryTrackingSocketDataSource disposed');
  }

  /// Parse raw STOMP message to DeliveryTrackingEntity
  DeliveryTrackingEntity? _parseDeliveryMessage(Map<String, dynamic> message) {
    try {
      final body = message['body'] as String?;
      if (body == null) return null;
      
      final data = jsonDecode(body) as Map<String, dynamic>;
      
      // Remove internal topic field if exists
      data.remove('_topic');
      
      return DeliveryTrackingEntity(
        id: data['id'] ?? 0,
        orderId: data['orderId'] ?? 0,
        shipperId: data['shipperId'],
        status: DeliveryStatus.fromValueOrDefault(data['status'] ?? 'pending'),
        pickupAddress: data['pickupAddress'] ?? '',
        pickupLat: (data['pickupLat'] ?? 0.0).toDouble(),
        pickupLng: (data['pickupLng'] ?? 0.0).toDouble(),
        deliveryAddress: data['deliveryAddress'] ?? '',
        deliveryLat: (data['deliveryLat'] ?? 0.0).toDouble(),
        deliveryLng: (data['deliveryLng'] ?? 0.0).toDouble(),
        shipperCurrentLat: data['shipperCurrentLat']?.toDouble(),
        shipperCurrentLng: data['shipperCurrentLng']?.toDouble(),
        assignedAt: data['assignedAt'] != null ? DateTime.tryParse(data['assignedAt']) : null,
        pickedUpAt: data['pickedUpAt'] != null ? DateTime.tryParse(data['pickedUpAt']) : null,
        deliveredAt: data['deliveredAt'] != null ? DateTime.tryParse(data['deliveredAt']) : null,
        estimatedDeliveryTime: data['estimatedDeliveryTime'] != null ? DateTime.tryParse(data['estimatedDeliveryTime']) : null,
        notes: data['notes']?.toString(),
      );
    } catch (e) {
      AppLogger.e('Error parsing delivery message', e);
      return null;
    }
  }
}
