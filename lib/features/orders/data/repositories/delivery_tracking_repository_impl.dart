import 'dart:async';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/socket/delivery_tracking_stomp_service.dart';
import '../dtos/current_delivery_dto.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/repositories/delivery_tracking_repository.dart';

/// Repository implementation chỉ transform data từ Service
/// Service đã quản lý StreamController, Repository chỉ transform raw → Entity
class DeliveryTrackingRepositoryImpl implements DeliveryTrackingRepository {
  final DeliveryTrackingStompService _stompService;
  final DeliveryTrackingRemoteDataSource _remoteDataSource;
  int? _currentOrderId;

  DeliveryTrackingRepositoryImpl(this._stompService, this._remoteDataSource);

  @override
  Stream<DeliveryTrackingEntity> get deliveryStream {
    // Transform stream từ Service thành Entity stream
    return _stompService.messageStream
        .where((rawData) => _isRelevantData(rawData))
        .map((rawData) => _parseDeliveryEntity(rawData));
    // .where((entity) => _isValidDeliveryEntity(entity));
  }

  @override
  Stream<bool> get connectionStream =>
      _stompService.connectionStream ?? const Stream.empty();

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

    return CurrentDeliveryDto.fromJson(data).toEntity();
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

  /// No dispose needed - Service handles stream cleanup
  void dispose() {
    stopTracking();
    // Service tự quản lý StreamController cleanup
  }
}
