import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../dtos/order_dto.dart';

/// Implementation của OrderRepository
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders() async {
    try {
      final result = await _remoteDataSource.getUserOrders();
      return result.fold(
        (exception) => left(_mapExceptionToFailure(exception)),
        (dtos) => right(dtos.map((dto) => dto.toEntity()).toList()),
      );
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(int orderId) async {
    try {
      final result = await _remoteDataSource.getOrderById(orderId);
      return result.fold(
        (exception) => left(_mapExceptionToFailure(exception)),
        (dto) => right(dto.toEntity()),
      );
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(OrderEntity order) async {
    try {
      final orderDto = order.toDto();
      final result = await _remoteDataSource.createOrder(orderDto);
      return result.fold(
        (exception) => left(_mapExceptionToFailure(exception)),
        (dto) => right(dto.toEntity()),
      );
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> updateOrderStatus(
    int orderId, 
    OrderStatus status,
  ) async {
    try {
      final result = await _remoteDataSource.updateOrderStatus(
        orderId, 
        status.value,
      );
      return result.fold(
        (exception) => left(_mapExceptionToFailure(exception)),
        (dto) => right(dto.toEntity()),
      );
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(int orderId) async {
    try {
      final result = await _remoteDataSource.cancelOrder(orderId);
      return result.fold(
        (exception) => left(_mapExceptionToFailure(exception)),
        (success) => right(success),
      );
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrdersByStatus(
    OrderStatus status,
  ) async {
    try {
      final result = await _remoteDataSource.getOrdersByStatus(status.value);
      return result.fold(
        (exception) => left(_mapExceptionToFailure(exception)),
        (dtos) => right(dtos.map((dto) => dto.toEntity()).toList()),
      );
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await _remoteDataSource.getOrderHistory(
        page: page,
        limit: limit,
      );
      return result.fold(
        (exception) => left(_mapExceptionToFailure(exception)),
        (dtos) => right(dtos.map((dto) => dto.toEntity()).toList()),
      );
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  /// Map Exception thành Failure
  Failure _mapExceptionToFailure(Exception exception) {
    final message = exception.toString().replaceFirst('Exception: ', '');
    
    if (message.toLowerCase().contains('connection') || 
        message.toLowerCase().contains('timeout') ||
        message.toLowerCase().contains('network')) {
      return NetworkFailure(message);
    }
    
    if (message.toLowerCase().contains('unauthorized') ||
        message.toLowerCase().contains('401')) {
      return UnauthorizedFailure(message);
    }
    
    if (message.toLowerCase().contains('forbidden') ||
        message.toLowerCase().contains('403')) {
      return ServerFailure(message);
    }
    
    if (message.toLowerCase().contains('validation') ||
        message.toLowerCase().contains('422')) {
      return ValidationFailure(message);
    }
    
    // Kiểm tra server errors (5xx)
    if (message.contains('500') || message.contains('502') || 
        message.contains('503') || message.contains('504')) {
      return ServerFailure(message);
    }
    
    return ServerFailure(message);
  }
}
