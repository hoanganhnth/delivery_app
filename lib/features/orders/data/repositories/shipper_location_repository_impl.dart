import 'dart:async';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/shipper_location_socket_service.dart';
import '../../domain/entities/shipper_location_entity.dart';
import '../../domain/repositories/shipper_location_repository.dart';

/// Simple repository implementation trực tiếp sử dụng Socket Service
/// Loại bỏ Datasource và Service layer để đơn giản hóa
class ShipperLocationRepositoryImpl implements ShipperLocationRepository {
  final ShipperLocationSocketService _socketService;
  
  final StreamController<ShipperLocationEntity> _locationController =
      StreamController<ShipperLocationEntity>.broadcast();
  
  StreamSubscription<Map<String, dynamic>>? _dataSubscription;
  int? _currentShipperId;
  
  ShipperLocationRepositoryImpl(this._socketService);
  
  @override
  Stream<ShipperLocationEntity> get locationStream => _locationController.stream;
  
  @override
  bool get isTracking => _currentShipperId != null && _socketService.isConnected;
  
  @override
  Future<Either<Failure, void>> startTrackingShipper(int shipperId) async {
    try {
      AppLogger.d('Starting shipper location tracking: $shipperId');
      
      // Stop previous tracking if any
      await stopTrackingShipper();
      
      // Ensure connection
      if (!_socketService.isConnected) {
        await _socketService.connect();
        await Future.delayed(const Duration(milliseconds: 1000));
      }
      
      // Subscribe to raw data stream and process
      _dataSubscription = _socketService.messageStream.listen(
        (rawData) => _processLocationData(rawData),
        onError: (error) {
          AppLogger.e('Error in location stream', error);
          _locationController.addError(error);
        },
      );
      
      // Start tracking
      _socketService.subscribeToShipper(shipperId);
      _currentShipperId = shipperId;
      
      AppLogger.i('Successfully started tracking shipper: $shipperId');
      return right(null);
    } catch (e) {
      AppLogger.e('Failed to start tracking shipper: $shipperId', e);
      await stopTrackingShipper();
      return left(const ServerFailure('Failed to start tracking'));
    }
  }
  
  @override
  Future<Either<Failure, void>> stopTrackingShipper() async {
    try {
      AppLogger.d('Stopping shipper location tracking');
      
      if (_currentShipperId != null) {
        _socketService.unsubscribeFromShipper(_currentShipperId!);
        _currentShipperId = null;
      }
      
      await _dataSubscription?.cancel();
      _dataSubscription = null;
      
      AppLogger.i('Stopped shipper location tracking');
      return right(null);
    } catch (e) {
      AppLogger.e('Error stopping tracking', e);
      return left(const ServerFailure('Failed to stop tracking'));
    }
  }
  
  /// Xử lý raw data từ WebSocket và transform thành entity
  void _processLocationData(Map<String, dynamic> rawData) {
    try {
      AppLogger.d('Processing shipper location data');
      
      final messageType = rawData['type'] as String?;
      
      if (messageType == 'location_update') {
        final locationData = rawData['data'] as Map<String, dynamic>?;
        if (locationData != null) {
          final entity = _parseLocationEntity(locationData);
          
          // Validate entity trước khi emit
          if (_isValidLocationEntity(entity)) {
            _locationController.add(entity);
            AppLogger.d('Successfully processed location update for shipper: ${entity.shipperId}');
          } else {
            AppLogger.w('Invalid location data received');
          }
        }
      } else if (messageType == 'error') {
        final errorMessage = rawData['message'] as String? ?? 'Unknown WebSocket error';
        AppLogger.e('WebSocket location error: $errorMessage');
        _locationController.addError(Exception(errorMessage));
      }
    } catch (e) {
      AppLogger.e('Error processing location data', e);
      // Don't stop stream, just log error
    }
  }
  
  /// Parse raw data thành ShipperLocationEntity
  ShipperLocationEntity _parseLocationEntity(Map<String, dynamic> data) {
    return ShipperLocationEntity(
      shipperId: data['shipperId'] ?? _currentShipperId ?? 0,
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'])
          : DateTime.now(),
    );
  }
  
  /// Validate entity data
  bool _isValidLocationEntity(ShipperLocationEntity entity) {
    return entity.shipperId > 0 &&
           entity.latitude.abs() <= 90 &&
           entity.longitude.abs() <= 180;
  }
  
  /// Dispose resources
  void dispose() {
    stopTrackingShipper();
    _locationController.close();
  }
}
