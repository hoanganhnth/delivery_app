import 'package:delivery_app/core/error/exceptions.dart';
import 'package:delivery_app/core/network/resources/page_dto.dart';
import 'package:delivery_app/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/order_dto.dart';
import 'package:delivery_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns a failure when order history API fails', () async {
    final repository = OrderRepositoryImpl(_FailingOrderRemoteDataSource());

    final result = await repository.getUserOrders();

    expect(result.isLeft(), isTrue);
    result.fold(
      (failure) => expect(failure.message, 'order API unavailable'),
      (_) => fail('API failure must not be replaced with production mock data'),
    );
  });

  test('returns a failure when order detail API fails', () async {
    final repository = OrderRepositoryImpl(_FailingOrderRemoteDataSource());

    final result = await repository.getOrderById(9);

    expect(result.isLeft(), isTrue);
    result.fold(
      (failure) => expect(failure.message, 'order API unavailable'),
      (_) => fail('API failure must not be replaced with production mock data'),
    );
  });
}

class _FailingOrderRemoteDataSource implements OrderRemoteDataSource {
  Never _fail() => throw const NetworkException('order API unavailable');

  @override
  Future<bool> cancelOrder(int orderId, {String? reason}) async => _fail();

  @override
  Future<OrderDto> createOrderWithDto(CreateOrderRequestDto request) async =>
      _fail();

  @override
  Future<OrderDto> getOrderById(num orderId) async => _fail();

  @override
  Future<PageDto<OrderDto>> getUserOrders(int page, int size) async => _fail();
}
