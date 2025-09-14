import 'dart:async';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/shipper_location_socket_service.dart';
import '../../domain/entities/shipper_location_entity.dart';
import '../../domain/repositories/shipper_location_repository.dart';

/// Repository implementation chỉ transform data từ Service
/// Service đã quản lý StreamController, Repository chỉ transform raw → Entity
class ShipperLocationRepositoryImpl implements ShipperLocationRepository {
  final ShipperLocationSocketService _socketService;
  int? _currentShipperId;
  
  ShipperLocationRepositoryImpl(this._socketService);
  
  @override
  Stream<ShipperLocationEntity> get locationStream {
    // Transform stream từ Service thành Entity stream
    return _socketService.messageStream
        .where((rawData) => _isRelevantLocation(rawData))
        .map((rawData) => _parseLocationEntity(rawData))
        .where((entity) => _isValidLocationEntity(entity));
  }
  
  @override
  bool get isTracking => _currentShipperId != null && _socketService.isConnected;
  
  @override
  Future<Either<Failure, void>> startTrackingShipper(int shipperId) async {
    try {
      AppLogger.d('Starting shipper location tracking: $shipperId');
      
      // Stop previous tracking if any
      await stopTrackingShipper();
      
      // Ensure connection với proper async handling
      if (!_socketService.isConnected) {
        await _socketService.connect(); // Không cần Future.delayed nữa!
      }
      
      // Service đã quản lý stream, Repository chỉ cần transform
      
      // Start tracking - chỉ khi đã connected
      if (_socketService.isConnected) {
        _socketService.subscribeToShipper(shipperId);
        _currentShipperId = shipperId;
      } else {
        throw Exception('Failed to establish WebSocket connection');
      }
      
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
      
      // No subscription to cancel - Service handles stream lifecycle
      
      AppLogger.i('Stopped shipper location tracking');
      return right(null);
    } catch (e) {
      AppLogger.e('Error stopping tracking', e);
      return left(const ServerFailure('Failed to stop tracking'));
    }
  }
  
  /// Check if location data is relevant to current tracking
  bool _isRelevantLocation(Map<String, dynamic> rawData) {
    final messageType = rawData['type'] as String?;
    if (messageType == 'location_update') {
      final locationData = rawData['data'] as Map<String, dynamic>?;
      final shipperId = locationData?['shipperId'];
      return shipperId != null && shipperId == _currentShipperId;
    }
    return false;
  }
  
  /// Parse raw data thành ShipperLocationEntity
  ShipperLocationEntity _parseLocationEntity(Map<String, dynamic> rawData) {
    // Extract location data from WebSocket message
    final locationData = rawData['data'] as Map<String, dynamic>? ?? rawData;
    
    return ShipperLocationEntity(
      shipperId: locationData['shipperId'] ?? _currentShipperId ?? 0,
      latitude: (locationData['latitude'] ?? 0.0).toDouble(),
      longitude: (locationData['longitude'] ?? 0.0).toDouble(),
      updatedAt: locationData['updatedAt'] != null
          ? DateTime.parse(locationData['updatedAt'])
          : DateTime.now(),
    );
  }
  
  /// Validate entity data
  bool _isValidLocationEntity(ShipperLocationEntity entity) {
    return entity.shipperId > 0 &&
           entity.latitude.abs() <= 90 &&
           entity.longitude.abs() <= 180;
  }
  
  /// No dispose needed - Service handles stream cleanup
  void dispose() {
    stopTrackingShipper();
    // Service tự quản lý StreamController cleanup
  }
}
