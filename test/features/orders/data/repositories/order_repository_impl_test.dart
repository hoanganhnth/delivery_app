import 'package:delivery_app/core/error/exceptions.dart';
import 'package:delivery_app/core/network/resources/page_dto.dart';
import 'package:delivery_app/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/order_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/order_item_dto.dart';
import 'package:delivery_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/entities/order_creation_command.dart';
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

  test('maps livestream identity into the create-order DTO', () async {
    const livestreamId = '00000000-0000-4000-8000-000000000001';
    final remote = _CapturingOrderRemoteDataSource();
    final repository = OrderRepositoryImpl(remote);

    final result = await repository.createOrder(
      const OrderCreationCommand(
        quoteId: '00000000-0000-4000-8000-000000000002',
        livestreamId: livestreamId,
        restaurantId: 201,
        deliveryAddress: '2 Đường Khách, TP.HCM',
        deliveryLat: 10.78,
        deliveryLng: 106.71,
        customerName: 'Customer Test',
        customerPhone: '0900000002',
        paymentMethod: 'COD',
        items: [OrderCreationItem(menuItemId: 301, quantity: 1)],
      ),
    );

    expect(result.isRight(), isTrue);
    expect(remote.request?.livestreamId, livestreamId);
  });
}

class _CapturingOrderRemoteDataSource implements OrderRemoteDataSource {
  CreateOrderRequestDto? request;

  @override
  Future<OrderDto> createOrderWithDto(CreateOrderRequestDto request) async {
    this.request = request;
    return OrderDto(
      id: 601,
      status: 'PENDING',
      customerName: 'Customer Test',
      customerPhone: '0900000002',
      deliveryAddress: '2 Đường Khách, TP.HCM',
      paymentMethod: 'COD',
      subtotalPrice: 50000,
      discountAmount: 0,
      shippingFee: 15000,
      totalAmount: 65000,
      items: const [
        OrderItemDto(
          id: 701,
          menuItemId: 301,
          menuItemName: 'Cơm test',
          quantity: 1,
          price: 50000,
        ),
      ],
      createdAt: DateTime.utc(2026, 9, 14),
      restaurantId: 201,
      restaurantName: 'Bếp test',
    );
  }

  @override
  Future<bool> cancelOrder(int orderId, {String? reason}) =>
      throw UnimplementedError();

  @override
  Future<OrderDto> getOrderById(num orderId) => throw UnimplementedError();

  @override
  Future<PageDto<OrderDto>> getUserOrders(int page, int size) =>
      throw UnimplementedError();
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
