import '../dtos/order_dto.dart';

/// Remote data source interface for orders
abstract class OrderRemoteDataSource {
  /// Lấy danh sách đơn hàng của người dùng
  Future<List<OrderDto>> getUserOrders();

  /// Lấy chi tiết đơn hàng theo ID
  Future<OrderDto> getOrderById(int orderId);

  /// Tạo đơn hàng mới
  Future<OrderDto> createOrder(OrderDto order);

  /// Cập nhật trạng thái đơn hàng
  Future<OrderDto> updateOrderStatus(int orderId, String status);

  /// Hủy đơn hàng
  Future<bool> cancelOrder(int orderId);

  /// Lấy danh sách đơn hàng theo trạng thái
  Future<List<OrderDto>> getOrdersByStatus(String status);

  /// Lấy lịch sử đơn hàng với phân trang
  Future<List<OrderDto>> getOrderHistory({
    int page = 1,
    int limit = 10,
  });
}
