import '../dtos/order_dto.dart';
import '../dtos/create_order_request_dto.dart';
import 'package:delivery_app/core/network/resources/page_dto.dart';

/// Remote data source interface for orders
abstract class OrderRemoteDataSource {
  /// Lấy danh sách đơn hàng của người dùng
  Future<PageDto<OrderDto>> getUserOrders(int page, int size);

  /// Lấy chi tiết đơn hàng theo ID
  Future<OrderDto> getOrderById(num orderId);

  /// Tạo đơn hàng mới với DTO
  Future<OrderDto> createOrderWithDto(CreateOrderRequestDto request);

  /// Tạo đơn hàng mới (legacy method)
  Future<OrderDto> createOrder(OrderDto order);

  /// Hủy đơn hàng
  Future<bool> cancelOrder(int orderId, {String? reason});

  /// Đánh giá shipper
  Future<bool> rateShipper(int shipperId, int orderId, int rating, String? comment);
}
