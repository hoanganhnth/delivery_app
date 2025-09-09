import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/order_entity.dart';

/// Repository interface for order management
abstract class OrderRepository {
  /// Lấy danh sách đơn hàng của người dùng
  Future<Either<Failure, List<OrderEntity>>> getUserOrders();

  /// Lấy chi tiết đơn hàng theo ID
  Future<Either<Failure, OrderEntity>> getOrderById(int orderId);

  /// Tạo đơn hàng mới
  Future<Either<Failure, OrderEntity>> createOrder(OrderEntity order);

  /// Cập nhật trạng thái đơn hàng
  Future<Either<Failure, OrderEntity>> updateOrderStatus(int orderId, OrderStatus status);

  /// Hủy đơn hàng
  Future<Either<Failure, bool>> cancelOrder(int orderId);

  /// Lấy danh sách đơn hàng theo trạng thái
  Future<Either<Failure, List<OrderEntity>>> getOrdersByStatus(OrderStatus status);

  /// Lấy lịch sử đơn hàng với phân trang
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory({
    int page = 1,
    int limit = 10,
  });
}
