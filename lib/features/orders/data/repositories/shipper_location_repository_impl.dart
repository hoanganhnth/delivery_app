import 'dart:async';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../datasources/shipper_location_datasource.dart';
import '../../domain/entities/shipper_location_entity.dart';
import '../../domain/repositories/shipper_location_repository.dart';

/// Repository implementation sử dụng trực tiếp DataSource
class ShipperLocationRepositoryImpl implements ShipperLocationRepository {
  final ShipperLocationDataSource _dataSource;
  String? _currentShipperId;
  
  ShipperLocationRepositoryImpl(this._dataSource);
  
  @override
  Stream<ShipperLocationEntity> get locationStream {
    // Sử dụng trực tiếp single entity stream và filter theo current shipper
    return _dataSource.locationStream
        .where((entity) => _currentShipperId != null && entity.shipperId.toString() == _currentShipperId)
        .where((entity) => _isValidLocationEntity(entity));
  }
  
  @override
  bool get isTracking => _currentShipperId != null;
  
  @override
  Future<Either<Failure, void>> startTrackingShipper(int shipperId) async {
    try {
      AppLogger.d('Starting shipper location tracking: $shipperId');
      
      // Connect nếu chưa kết nối
      final connectionStatus = await _dataSource.connectionStream.first;
      if (!connectionStatus) {
        final connected = await _dataSource.connect();
        if (!connected) {
          return left(const NetworkFailure('Failed to connect to location service'));
        }
      }
      
      // Subscribe to shipper
      final shipperIdString = shipperId.toString();
      final connectionStatus2 = await _dataSource.connectionStream.first;
      if (connectionStatus2) {
        await _dataSource.subscribeToShipper(shipperIdString);
        _currentShipperId = shipperIdString;
        AppLogger.i('Started tracking shipper: $shipperId');
        return right(null);
      } else {
        return left(const NetworkFailure('Not connected to location service'));
      }
    } catch (e) {
      AppLogger.e('Error starting tracking: $e');
      return left(const ServerFailure('Failed to start tracking'));
    }
  }
  
  @override
  Future<Either<Failure, void>> stopTrackingShipper() async {
    try {
      AppLogger.d('Stopping shipper location tracking');
      
      if (_currentShipperId != null) {
        await _dataSource.unsubscribeFromShipper(_currentShipperId!);
        _currentShipperId = null;
      }
      
      AppLogger.i('Stopped shipper location tracking');
      return right(null);
    } catch (e) {
      AppLogger.e('Error stopping tracking: $e');
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
