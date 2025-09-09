import 'package:fpdart/fpdart.dart';
import '../dtos/order_dto.dart';

/// Remote data source interface for orders
abstract class OrderRemoteDataSource {
  /// Lấy danh sách đơn hàng của người dùng
  Future<Either<Exception, List<OrderDto>>> getUserOrders();

  /// Lấy chi tiết đơn hàng theo ID
  Future<Either<Exception, OrderDto>> getOrderById(int orderId);

  /// Tạo đơn hàng mới
  Future<Either<Exception, OrderDto>> createOrder(OrderDto order);

  /// Cập nhật trạng thái đơn hàng
  Future<Either<Exception, OrderDto>> updateOrderStatus(int orderId, String status);

  /// Hủy đơn hàng
  Future<Either<Exception, bool>> cancelOrder(int orderId);

  /// Lấy danh sách đơn hàng theo trạng thái
  Future<Either<Exception, List<OrderDto>>> getOrdersByStatus(String status);

  /// Lấy lịch sử đơn hàng với phân trang
  Future<Either<Exception, List<OrderDto>>> getOrderHistory({
    int page = 1,
    int limit = 10,
  });
}
