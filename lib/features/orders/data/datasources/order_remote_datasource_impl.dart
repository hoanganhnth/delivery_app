import 'package:fpdart/fpdart.dart';
import '../dtos/order_dto.dart';
import 'order_remote_datasource.dart';
import 'order_api_service.dart';
import '../../../../core/data/dtos/response_handler.dart';

/// Implementation của OrderRemoteDataSource sử dụng Retrofit API
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final OrderApiService _apiService;

  OrderRemoteDataSourceImpl(this._apiService);

  @override
  Future<Either<Exception, List<OrderDto>>> getUserOrders() async {
    return ResponseHandler.safeApiCallSimple(() => _apiService.getUserOrders());
  }

  @override
  Future<Either<Exception, OrderDto>> getOrderById(int orderId) async {
    return ResponseHandler.safeApiCallSimple(() => _apiService.getOrderById(orderId));
  }

  @override
  Future<Either<Exception, OrderDto>> createOrder(OrderDto order) async {
    return ResponseHandler.safeApiCallSimple(() => _apiService.createOrder(order));
  }

  @override
  Future<Either<Exception, OrderDto>> updateOrderStatus(
    int orderId, 
    String status,
  ) async {
    return ResponseHandler.safeApiCallSimple(
      () => _apiService.updateOrderStatus(orderId, {'status': status}),
    );
  }

  @override
  Future<Either<Exception, bool>> cancelOrder(int orderId) async {
    return ResponseHandler.safeApiCallWithResponse(
      () => _apiService.cancelOrder(orderId),
      (data) => data == true,
    );
  }

  @override
  Future<Either<Exception, List<OrderDto>>> getOrdersByStatus(
    String status,
  ) async {
    return ResponseHandler.safeApiCallSimple(() => _apiService.getOrdersByStatus(status));
  }

  @override
  Future<Either<Exception, List<OrderDto>>> getOrderHistory({
    int page = 1,
    int limit = 10,
  }) async {
    return ResponseHandler.safeApiCallSimple(() => _apiService.getOrderHistory(page, limit));
  }
}
