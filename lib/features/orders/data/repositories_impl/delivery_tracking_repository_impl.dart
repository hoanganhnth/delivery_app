import 'dart:async';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/delivery_tracking_stomp_service.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/repositories/delivery_tracking_repository.dart';

/// Simple repository implementation trực tiếp sử dụng STOMP Service
/// Loại bỏ Datasource và Service layer để đơn giản hóa
class DeliveryTrackingRepositoryImpl implements DeliveryTrackingRepository {
  final DeliveryTrackingStompService _stompService;
  
  final StreamController<DeliveryTrackingEntity> _deliveryController =
      StreamController<DeliveryTrackingEntity>.broadcast();
  
  StreamSubscription<Map<String, dynamic>>? _dataSubscription;
  int? _currentOrderId;
  
  DeliveryTrackingRepositoryImpl(this._stompService);
  
  @override
  Stream<DeliveryTrackingEntity> get deliveryStream => _deliveryController.stream;
  
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
      
      // Subscribe to raw data stream and process
      _dataSubscription = _stompService.messageStream.listen(
        (rawData) => _processDeliveryData(rawData),
        onError: (error) {
          AppLogger.e('Error in delivery stream', error);
          _deliveryController.addError(error);
        },
      );
      
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
      
      await _dataSubscription?.cancel();
      _dataSubscription = null;
      
      AppLogger.i('Stopped delivery tracking');
      return right(null);
    } catch (e) {
      AppLogger.e('Error stopping delivery tracking', e);
      return left(const ServerFailure('Failed to stop tracking'));
    }
  }
  
  /// Xử lý raw data từ STOMP và transform thành entity
  void _processDeliveryData(Map<String, dynamic> rawData) {
    try {
      final topic = rawData['_topic'] as String?;
      AppLogger.d('Processing delivery data from topic: $topic');
      
      // Remove internal topic field
      final data = Map<String, dynamic>.from(rawData);
      data.remove('_topic');
      
      final entity = _parseDeliveryEntity(data);
      
      // Validate entity trước khi emit
      if (_isValidDeliveryEntity(entity)) {
        _deliveryController.add(entity);
        AppLogger.d('Successfully processed delivery update: ${entity.status}');
      } else {
        AppLogger.w('Invalid delivery data received');
      }
    } catch (e) {
      AppLogger.e('Error processing delivery data', e);
      // Don't stop stream, just log error
    }
  }
  
  /// Parse raw data thành DeliveryTrackingEntity
  DeliveryTrackingEntity _parseDeliveryEntity(Map<String, dynamic> data) {
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
  bool _isValidDeliveryEntity(DeliveryTrackingEntity entity) {
    return entity.orderId > 0 &&
           entity.status.isNotEmpty &&
           entity.pickupLat.abs() <= 90 &&
           entity.pickupLng.abs() <= 180 &&
           entity.deliveryLat.abs() <= 90 &&
           entity.deliveryLng.abs() <= 180;
  }
  
  /// Dispose resources
  void dispose() {
    stopTracking();
    _deliveryController.close();
  }
}
