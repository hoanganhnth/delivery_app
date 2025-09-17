import 'package:delivery_app/core/error/error_mapper.dart';
import 'package:delivery_app/core/error/exceptions.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../datasources/mock_order_service.dart';
import '../dtos/order_dto.dart';
import '../dtos/create_order_request_dto.dart';

/// Implementation của OrderRepository
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;
  final MockOrderService _mockOrderService;

  OrderRepositoryImpl(this._remoteDataSource, this._mockOrderService);

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders() async {
    try {
      final dtos = await _remoteDataSource.getUserOrders();
      return right(dtos.map((dto) => dto.toEntity()).toList());
    } on Exception {
      AppLogger.w('API failed, using mock data');
      // Fallback to mock data when API fails
      final mockOrders = _mockOrderService.getMockOrders();
      return right(mockOrders);
    } catch (e) {
      AppLogger.w('Unexpected error, using mock data');
      final mockOrders = _mockOrderService.getMockOrders();
      return right(mockOrders);
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId) async {
    try {
      final dto = await _remoteDataSource.getOrderById(orderId);
      return right(dto.toEntity());
    } on Exception catch (e1) {
      AppLogger.w('API failed for order $orderId by $e1, using mock data');
      // Fallback to mock data when API fails
      final mockOrder = _mockOrderService.getMockOrderById(orderId);
      if (mockOrder != null) {
        return right(mockOrder);
      }
      return left(
        ServerFailure(
          e1 is ServerException ? e1.message : 'Failed to fetch order',
        ),
      );
    } catch (e) {
      AppLogger.w('Unexpected error for order $orderId, using mock data');
      final mockOrder = _mockOrderService.getMockOrderById(orderId);
      if (mockOrder != null) {
        return right(mockOrder);
      }
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(CreateOrderRequestDto request) async {
    try {
      // Chuyển CreateOrderRequestDto thành OrderEntity để gọi API
      final orderEntity = request.toEntity();
      final orderDto = orderEntity.toDto();
      final dto = await _remoteDataSource.createOrder(orderDto);
      return right(dto.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(int orderId) async {
    try {
      final success = await _remoteDataSource.cancelOrder(orderId);
      return right(success);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
