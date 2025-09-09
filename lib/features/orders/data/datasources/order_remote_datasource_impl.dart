import 'package:dio/dio.dart';

import '../dtos/order_dto.dart';
import 'order_api_service.dart';
import 'order_remote_datasource.dart';
import '../../../../core/data/dtos/response_handler.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/logger/app_logger.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final OrderApiService _apiService;

  OrderRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<OrderDto>> getUserOrders() async {
    try {
      AppLogger.d('Getting user orders');
      final response = await _apiService.getUserOrders();
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} orders');
      
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get user orders', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting user orders', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<OrderDto> getOrderById(num orderId) async {
    try {
      AppLogger.d('Getting order by id: $orderId');
      final response = await _apiService.getOrderById(orderId);
      AppLogger.i('Successfully retrieved order: $orderId');
      
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get order with id: $orderId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting order', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<OrderDto> createOrder(OrderDto order) async {
    try {
      AppLogger.d('Creating new order');
      final response = await _apiService.createOrder(order);
      AppLogger.i('Successfully created order');
      
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to create order', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error creating order', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<bool> cancelOrder(int orderId) async {
    try {
      AppLogger.d('Cancelling order: $orderId');
      final response = await _apiService.cancelOrder(orderId);
      AppLogger.i('Successfully cancelled order: $orderId');
      
      if (response.isSuccess) {
        return response.data == true;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to cancel order: $orderId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error cancelling order', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
