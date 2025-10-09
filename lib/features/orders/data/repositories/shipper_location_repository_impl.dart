import 'dart:async';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../datasources/shipper_location_socket_datasource.dart';
import '../../domain/entities/shipper_location_entity.dart';
import '../../domain/repositories/shipper_location_repository.dart';

/// Repository implementation sử dụng trực tiếp DataSource
class ShipperLocationRepositoryImpl implements ShipperLocationRepository {
  final ShipperLocationSocketDataSource _dataSource;
  int? _currentShipperId;
  
  ShipperLocationRepositoryImpl(this._dataSource);
  
  @override
  Stream<ShipperLocationEntity> get locationStream {
    // Sử dụng trực tiếp stream từ DataSource
    return _dataSource.locationStream
        .where((entity) => _isValidLocationEntity(entity));
  }
  
  @override
  bool get isTracking => _currentShipperId != null && _dataSource.isConnected;
  
  @override
  Future<Either<Failure, void>> startTrackingShipper(int shipperId) async {
    try {
      // AppLogger.d('Starting shipper location tracking: $shipperId');
      
      // Stop previous tracking if any
      // await stopTrackingShipper();
      
      // Ensure connection với proper async handling
      if (!_dataSource.isConnected) {
        await _dataSource.connect(); // Không cần Future.delayed nữa!
      }
      
      // DataSource đã quản lý stream, Repository chỉ cần transform
      
      // Start tracking - chỉ khi đã connected
      if (_dataSource.isConnected) {
        _dataSource.subscribeToShipper(shipperId);
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
      // AppLogger.d('Stopping shipper location tracking');
      
      if (_currentShipperId != null) {
        _dataSource.unsubscribeFromShipper(_currentShipperId!);
        _currentShipperId = null;
      }
      
      // No subscription to cancel - DataSource handles stream lifecycle
      
      // AppLogger.i('Stopped shipper location tracking');
      return right(null);
    } catch (e) {
      AppLogger.e('Error stopping tracking', e);
      return left(const ServerFailure('Failed to stop tracking'));
    }
  }
  
  /// Validate entity data
  bool _isValidLocationEntity(ShipperLocationEntity entity) {
    return entity.shipperId > 0 &&
           entity.latitude.abs() <= 90 &&
           entity.longitude.abs() <= 180;
  }
  
  /// No dispose needed - DataSource handles stream cleanup
  void dispose() {
    stopTrackingShipper();
    // DataSource tự quản lý StreamController cleanup
  }
}
