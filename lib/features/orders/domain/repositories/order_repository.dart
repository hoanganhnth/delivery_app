import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/order_entity.dart';
import '../../data/dtos/create_order_request_dto.dart';

/// Repository interface for order management
abstract class OrderRepository {
  /// Lấy danh sách đơn hàng của người dùng
  Future<Either<Failure, List<OrderEntity>>> getUserOrders();

  /// Lấy chi tiết đơn hàng theo ID
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId);

  /// Tạo đơn hàng mới với CreateOrderRequestDto
  Future<Either<Failure, OrderEntity>> createOrder(CreateOrderRequestDto request);

  /// Hủy đơn hàng
  Future<Either<Failure, bool>> cancelOrder(int orderId);
}
