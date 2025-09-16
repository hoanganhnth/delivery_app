import 'dart:async';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/delivery_tracking_stomp_service.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/delivery_status.dart';
import '../../domain/repositories/delivery_tracking_repository.dart';

/// Repository implementation chỉ transform data từ Service
/// Service đã quản lý StreamController, Repository chỉ transform raw → Entity
class DeliveryTrackingRepositoryImpl implements DeliveryTrackingRepository {
  final DeliveryTrackingStompService _stompService;
  int? _currentOrderId;
  
  DeliveryTrackingRepositoryImpl(this._stompService);
  
  @override
  Stream<DeliveryTrackingEntity> get deliveryStream {
    // Transform stream từ Service thành Entity stream
    return _stompService.messageStream
        .where((rawData) => _isRelevantData(rawData))
        .map((rawData) => _parseDeliveryEntity(rawData));
        // .where((entity) => _isValidDeliveryEntity(entity));
  }
  
  @override
  Stream<bool> get connectionStream => _stompService.connectionStream ?? const Stream.empty();
  
  @override
  bool get isTracking => _currentOrderId != null && _stompService.isConnected;
  
  @override
  bool get isConnected => _stompService.isConnected;
  
  @override
  Future<Either<Failure, void>> connect() async {
    try {
      AppLogger.i('Connecting to STOMP service...');
      await _stompService.connect();
      return right(null);
    } catch (e) {
      AppLogger.e('Failed to connect to STOMP service', e);
      return left(ServerFailure('Không thể kết nối: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    try {
      AppLogger.i('Disconnecting from STOMP service...');
      await _stompService.disconnect();
      _currentOrderId = null;
      return right(null);
    } catch (e) {
      AppLogger.e('Failed to disconnect from STOMP service', e);
      return left(ServerFailure('Không thể ngắt kết nối: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> refresh() async {
    try {
      AppLogger.i('Refreshing STOMP connection...');
      await _stompService.disconnect();
      await Future.delayed(const Duration(milliseconds: 500));
      await _stompService.connect();
      return right(null);
    } catch (e) {
      AppLogger.e('Failed to refresh STOMP connection', e);
      return left(ServerFailure('Không thể làm mới kết nối: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> startTracking(int orderId) async {
    try {
      AppLogger.d('Starting delivery tracking for order: $orderId');
      
      // Stop previous tracking if any
      await stopTracking();
      
      // Ensure connection với proper async handling
      if (!_stompService.isConnected) {
        await _stompService.connect(); // Không cần Future.delayed nữa!
      }
      
      // Service đã quản lý stream, Repository chỉ cần transform
      
      // Start tracking - chỉ khi đã connected
      if (_stompService.isConnected) {
        _stompService.subscribeToOrder(orderId);
        _currentOrderId = orderId;
      } else {
        throw Exception('Failed to establish STOMP connection');
      }
      
      AppLogger.i('Successfully started tracking order: $orderId');
      return right(null);
    } catch (e) {
      AppLogger.e('Failed to start tracking order: $orderId', e);
      await stopTracking();
      return left(const ServerFailure('Failed to start tracking'));
    }
  }
  
  @override
  Future<Either<Failure, void>> stopTracking() async {
    try {
      AppLogger.d('Stopping delivery tracking');
      
      if (_currentOrderId != null) {
        _stompService.unsubscribeFromOrder(_currentOrderId!);
        _currentOrderId = null;
      }
      
      // No subscription to cancel - Service handles stream lifecycle
      
      AppLogger.i('Stopped delivery tracking');
      return right(null);
    } catch (e) {
      AppLogger.e('Error stopping delivery tracking', e);
      return left(const ServerFailure('Failed to stop tracking'));
    }
  }
  
  /// Check if raw data is relevant to current tracking
  bool _isRelevantData(Map<String, dynamic> rawData) {
    final orderId = rawData['orderId'];
    return orderId != null && orderId == _currentOrderId;
  }
  
  /// Parse raw data thành DeliveryTrackingEntity
  DeliveryTrackingEntity _parseDeliveryEntity(Map<String, dynamic> rawData) {
    // Remove internal topic field if exists
    final data = Map<String, dynamic>.from(rawData);
    data.remove('_topic');
    
    return DeliveryTrackingEntity(
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
  }
  
  /// Validate entity data
  // bool _isValidDeliveryEntity(DeliveryTrackingEntity entity) {
  //   return entity.orderId > 0 &&
  //          entity.status.isNotEmpty &&
  //          entity.pickupLat.abs() <= 90 &&
  //          entity.pickupLng.abs() <= 180 &&
  //          entity.deliveryLat.abs() <= 90 &&
  //          entity.deliveryLng.abs() <= 180;
  // }
  
  @override
  Future<Either<Failure, DeliveryTrackingEntity>> getCurrentDelivery(int orderId) async {
    try {
      AppLogger.i('Getting current delivery for order: $orderId via REST API');
      
      // Sử dụng REST API để lấy delivery hiện tại
      // Tạm thời trả về mock data, implement API call sau khi có datasource
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
      
      // Mock delivery data for testing
      final mockDelivery = DeliveryTrackingEntity(
        id: orderId * 1000, // Mock ID
        orderId: orderId,
        shipperId: 14, // Fixed shipper ID for testing
        status: DeliveryStatus.delivering,
        pickupAddress: 'Nhà hàng ABC, Q1, HCM',
        pickupLat: 10.762622,
        pickupLng: 106.660172,
        deliveryAddress: 'Tòa nhà XYZ, Q3, HCM',
        deliveryLat: 10.795588,
        deliveryLng: 106.717055,
        estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 30)),
        notes: 'Giao hàng cẩn thận',
      );
      
      AppLogger.i('Successfully retrieved current delivery for order: $orderId');
      return right(mockDelivery);
    } catch (e) {
      AppLogger.e('Failed to get current delivery for order: $orderId', e);
      return left(ServerFailure('Không thể lấy thông tin delivery: ${e.toString()}'));
    }
  }

  /// No dispose needed - Service handles stream cleanup
  void dispose() {
    stopTracking();
    // Service tự quản lý StreamController cleanup
  }
}
