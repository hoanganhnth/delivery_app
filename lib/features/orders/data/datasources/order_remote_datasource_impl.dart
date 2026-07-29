import 'package:dio/dio.dart';

import '../dtos/order_dto.dart';
import '../dtos/create_order_request_dto.dart';
import 'order_api_service.dart';
import 'order_remote_datasource.dart';
import '../../../../core/error/dio_exception_handler.dart';
import '../../../../core/network/resources/base_response_dto.dart';
import '../../../../core/utils/logger/app_logger.dart';

import 'package:delivery_app/core/network/resources/page_dto.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final OrderApiService _apiService;

  OrderRemoteDataSourceImpl(this._apiService);

  @override
  Future<PageDto<OrderDto>> getUserOrders(int page, int size) async {
    try {
      AppLogger.d('Getting user orders page $page size $size');
      final response = await _apiService.getUserOrders(page, size);
      AppLogger.i(
        'Successfully retrieved ${response.data?.items.length ?? 0} orders',
      );

      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get user orders', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting user orders', e);
      throw const FormatException('Invalid order history response');
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
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting order', e);
      throw const FormatException('Invalid order detail response');
    }
  }

  @override
  Future<OrderDto> createOrderWithDto(CreateOrderRequestDto request) async {
    try {
      AppLogger.d('Creating new order with DTO');
      final response = await _apiService.createOrderWithDto(request);
      AppLogger.i('Successfully created order with DTO');

      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to create order with DTO', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error creating order with DTO', e);
      throw const FormatException('Invalid create-order response');
    }
  }

  @override
  Future<bool> cancelOrder(int orderId, {String? reason}) async {
    try {
      AppLogger.d('Cancelling order: $orderId');
      final response = await _apiService.cancelOrder(orderId, {
        'reason': reason,
      });
      AppLogger.i('Successfully cancelled order: $orderId');

      if (response.isSuccess) {
        return true;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to cancel order: $orderId', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error cancelling order', e);
      throw const FormatException('Invalid cancel-order response');
    }
  }
}
