import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

/// UseCase để lấy danh sách đơn hàng của người dùng
class GetUserOrdersUseCase {
  final OrderRepository repository;

  GetUserOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await repository.getUserOrders();
  }
}

/// UseCase để lấy chi tiết đơn hàng theo ID
class GetOrderByIdUseCase {
  final OrderRepository repository;

  GetOrderByIdUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call(num orderId) async {
    if (orderId <= 0) {
      return left(const ValidationFailure('Order ID must be greater than 0'));
    }
    return await repository.getOrderById(orderId);
  }
}

/// UseCase để tạo đơn hàng mới
class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call(OrderEntity order) async {
    // Validate order
    if (order.items.isEmpty) {
      return left(const ValidationFailure('Order must have at least one item'));
    }
    
    if (order.customerName.trim().isEmpty) {
      return left(const ValidationFailure('Customer name is required'));
    }
    
    if (order.customerPhone.trim().isEmpty) {
      return left(const ValidationFailure('Customer phone is required'));
    }
    
    if (order.deliveryAddress.trim().isEmpty) {
      return left(const ValidationFailure('Delivery address is required'));
    }

    return await repository.createOrder(order);
  }
}

/// UseCase để cập nhật trạng thái đơn hàng
// class UpdateOrderStatusUseCase {
//   final OrderRepository repository;

//   UpdateOrderStatusUseCase(this.repository);

//   Future<Either<Failure, OrderEntity>> call(UpdateOrderStatusParams params) async {
//     if (params.orderId <= 0) {
//       return left(const ValidationFailure('Order ID must be greater than 0'));
//     }
    
//     return await repository.updateOrderStatus(params.orderId, params.status);
//   }
// }

class UpdateOrderStatusParams {
  final int orderId;
  final OrderStatus status;

  UpdateOrderStatusParams({
    required this.orderId,
    required this.status,
  });
}

/// UseCase để hủy đơn hàng
class CancelOrderUseCase {
  final OrderRepository repository;

  CancelOrderUseCase(this.repository);

  Future<Either<Failure, bool>> call(int orderId) async {
    if (orderId <= 0) {
      return left(const ValidationFailure('Order ID must be greater than 0'));
    }
    
    return await repository.cancelOrder(orderId);
  }
}
