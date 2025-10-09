import 'dart:async';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource.dart';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_socket_datasource.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/logger/app_logger.dart';
import '../dtos/current_delivery_dto.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/repositories/delivery_tracking_repository.dart';

/// Repository implementation sử dụng trực tiếp DataSource
/// DataSource đã quản lý stream và entity parsing
class DeliveryTrackingRepositoryImpl implements DeliveryTrackingRepository {
  final DeliveryTrackingSocketDataSource _socketDataSource;
  final DeliveryTrackingRemoteDataSource _remoteDataSource;
  int? _currentOrderId;

  DeliveryTrackingRepositoryImpl(this._socketDataSource, this._remoteDataSource);

  @override
  Stream<DeliveryTrackingEntity> get deliveryStream {
    // Sử dụng trực tiếp stream từ DataSource
    return _socketDataSource.deliveryStream;
  }

  @override
  Stream<bool> get connectionStream =>
      _socketDataSource.connectionStream;

  @override
  bool get isTracking => _currentOrderId != null && _socketDataSource.isConnected;

  @override
  bool get isConnected => _socketDataSource.isConnected;

  @override
  Future<Either<Failure, void>> connect() async {
    try {
      AppLogger.i('Connecting to STOMP DataSource...');
      await _socketDataSource.connect();
      return right(null);
    } catch (e) {
      AppLogger.e('Failed to connect to STOMP DataSource', e);
      return left(ServerFailure('Không thể kết nối: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    try {
      AppLogger.i('Disconnecting from STOMP DataSource...');
      await _socketDataSource.disconnect();
      _currentOrderId = null;
      return right(null);
    } catch (e) {
      AppLogger.e('Failed to disconnect from STOMP DataSource', e);
      return left(ServerFailure('Không thể ngắt kết nối: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> refresh() async {
    try {
      AppLogger.i('Refreshing STOMP connection...');
      await _socketDataSource.disconnect();
      await Future.delayed(const Duration(milliseconds: 500));
      await _socketDataSource.connect();
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
      if (!_socketDataSource.isConnected) {
        await _socketDataSource.connect(); // Không cần Future.delayed nữa!
      }

      // DataSource đã quản lý stream, Repository chỉ cần sử dụng

      // Start tracking - chỉ khi đã connected
      if (_socketDataSource.isConnected) {
        _socketDataSource.subscribeToOrder(orderId);
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
        _socketDataSource.unsubscribeFromOrder(_currentOrderId!);
        _currentOrderId = null;
      }

      // No subscription to cancel - DataSource handles stream lifecycle

      AppLogger.i('Stopped delivery tracking');
      return right(null);
    } catch (e) {
      AppLogger.e('Error stopping delivery tracking', e);
      return left(const ServerFailure('Failed to stop tracking'));
    }
  }

  @override
  Future<Either<Failure, DeliveryTrackingEntity>> getCurrentDelivery(
    int orderId,
  ) async {
    try {
      AppLogger.d('Getting current delivery for order: $orderId via REST API');
      
      final response = await _remoteDataSource.getCurrentDelivery(orderId);
      
      if (response.isSuccess && response.data != null) {
        final entity = response.data!.toEntity();
        AppLogger.i(
          'Successfully retrieved current delivery for order: $orderId',
        );
        return right(entity);
      } else {
        AppLogger.w('Current delivery API returned error: ${response.message}');
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      AppLogger.e('Failed to get current delivery for order: $orderId', e);
      return left(mapExceptionToFailure(e));
    } catch (e) {
      AppLogger.e('Unexpected error getting current delivery', e);
      return left(
        const ServerFailure('Không thể lấy thông tin delivery'),
      );
    }
  }

  /// No dispose needed - DataSource handles stream cleanup
  void dispose() {
    stopTracking();
    // DataSource tự quản lý StreamController cleanup
  }
}
