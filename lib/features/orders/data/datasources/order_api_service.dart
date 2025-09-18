import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dtos/order_dto.dart';
import '../dtos/create_order_request_dto.dart';

part 'order_api_service.g.dart';

@RestApi()
abstract class OrderApiService {
  factory OrderApiService(Dio dio) = _OrderApiService;

  /// Lấy danh sách đơn hàng của người dùng
  @GET(ApiConstants.getOrdersByUser)
  Future<BaseResponseDto<List<OrderDto>>> getUserOrders();

  /// Lấy chi tiết đơn hàng theo ID
  @GET('${ApiConstants.order}/{id}')
  Future<BaseResponseDto<OrderDto>> getOrderById(@Path('id') num orderId);

  /// Tạo đơn hàng mới với CreateOrderRequestDto
  @POST(ApiConstants.order)
  Future<BaseResponseDto<OrderDto>> createOrderWithDto(@Body() CreateOrderRequestDto request);

  /// Tạo đơn hàng mới (legacy method)
  @POST(ApiConstants.order)
  Future<BaseResponseDto<OrderDto>> createOrder(@Body() OrderDto order);

  // /// Cập nhật trạng thái đơn hàng
  // @PUT('/orders/{id}/status')
  // Future<BaseResponseDto<OrderDto>> updateOrderStatus(
  //   @Path('id') int orderId,
  //   @Body() Map<String, String> status,
  // );

  /// Hủy đơn hàng
  @PUT('${ApiConstants.order}/{id}')
  Future<BaseResponseDto<bool>> cancelOrder(@Path('id') int orderId);

  // /// Lấy danh sách đơn hàng theo trạng thái
  // @GET('/orders')
  // Future<BaseResponseDto<List<OrderDto>>> getOrdersByStatus(
  //   @Query('status') String status,
  // );

  // /// Lấy lịch sử đơn hàng với phân trang
  // @GET('/orders/history')
  // Future<BaseResponseDto<List<OrderDto>>> getOrderHistory(
  //   @Query('page') int page,
  //   @Query('limit') int limit,
  // );
}
