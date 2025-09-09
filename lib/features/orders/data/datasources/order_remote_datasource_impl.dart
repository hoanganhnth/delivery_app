import 'package:dio/dio.dart';
import '../dtos/order_dto.dart';
import 'order_remote_datasource.dart';
import 'order_api_service.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/data/dtos/response_handler.dart';

/// Implementation của OrderRemoteDataSource sử dụng Retrofit API
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final OrderApiService _apiService;

  OrderRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<OrderDto>> getUserOrders() async {
    try {
      final response = await _apiService.getUserOrders();
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<OrderDto> getOrderById(int orderId) async {
    try {
      final response = await _apiService.getOrderById(orderId);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<OrderDto> createOrder(OrderDto order) async {
    try {
      final response = await _apiService.createOrder(order);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<OrderDto> updateOrderStatus(int orderId, String status) async {
    try {
      final response = await _apiService.updateOrderStatus(orderId, {
        'status': status,
      });
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<bool> cancelOrder(int orderId) async {
    try {
      final response = await _apiService.cancelOrder(orderId);
      if (response.isSuccess) {
        return response.data == true;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<OrderDto>> getOrdersByStatus(String status) async {
    try {
      final response = await _apiService.getOrdersByStatus(status);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<OrderDto>> getOrderHistory({int page = 1, int limit = 10}) async {
    try {
      final response = await _apiService.getOrderHistory(page, limit);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
