import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/order_entity.dart';

/// Repository interface for order management
abstract class OrderRepository {
  /// Lấy danh sách đơn hàng của người dùng
  Future<Either<Failure, List<OrderEntity>>> getUserOrders();

  /// Lấy chi tiết đơn hàng theo ID
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId);

  /// Tạo đơn hàng mới
  Future<Either<Failure, OrderEntity>> createOrder(OrderEntity order);

  /// Hủy đơn hàng
  Future<Either<Failure, bool>> cancelOrder(int orderId);
}
