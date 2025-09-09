import '../dtos/order_dto.dart';

/// Remote data source interface for orders
abstract class OrderRemoteDataSource {
  /// Lấy danh sách đơn hàng của người dùng
  Future<List<OrderDto>> getUserOrders();

  /// Lấy chi tiết đơn hàng theo ID
  Future<OrderDto> getOrderById(int orderId);

  /// Tạo đơn hàng mới
  Future<OrderDto> createOrder(OrderDto order);

  /// Hủy đơn hàng
  Future<bool> cancelOrder(int orderId);
}
