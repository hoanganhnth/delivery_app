import 'dart:convert';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/network/resources/page_dto.dart';
import 'package:delivery_app/features/orders/data/datasources/order_api_service.dart';
import 'package:delivery_app/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:delivery_app/features/orders/data/datasources/order_remote_datasource_impl.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/order_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/order_item_dto.dart';
import 'package:delivery_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/entities/order_creation_command.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

const command = OrderCreationCommand(
  quoteId: '00000000-0000-4000-8000-000000000001',
  livestreamId: '00000000-0000-4000-8000-000000000002',
  idempotencyKey: 'checkout-1',
  restaurantId: 201,
  deliveryAddress: 'Home',
  deliveryLat: 10.78,
  deliveryLng: 106.71,
  customerName: 'Customer',
  customerPhone: '0900000001',
  paymentMethod: 'COD',
  notes: 'warm',
  voucherIds: [9],
  selectionMode: 'MANUAL',
  items: [
    OrderCreationItem(
      menuItemId: 301,
      quantity: 2,
      notes: 'hot',
      flashSaleItemId: 88,
    ),
  ],
);
const body = <String, dynamic>{
  'quoteId': '00000000-0000-4000-8000-000000000001',
  'livestreamId': '00000000-0000-4000-8000-000000000002',
  'restaurantId': 201,
  'deliveryAddress': 'Home',
  'deliveryLat': 10.78,
  'deliveryLng': 106.71,
  'customerName': 'Customer',
  'customerPhone': '0900000001',
  'paymentMethod': 'COD',
  'notes': 'warm',
  'voucherIds': [9],
  'selectionMode': 'MANUAL',
  'items': [
    {'menuItemId': 301, 'quantity': 2, 'notes': 'hot', 'flashSaleItemId': 88},
  ],
};
const orderItem = <String, dynamic>{
  'id': 701,
  'menuItemId': 301,
  'menuItemName': 'Rice',
  'quantity': 2,
  'price': 50000.0,
  'notes': 'hot',
};
const order = <String, dynamic>{
  'id': 601,
  'status': 'PENDING',
  'customerName': 'Customer',
  'customerPhone': '0900000001',
  'deliveryAddress': 'Home',
  'paymentMethod': 'COD',
  'subtotalPrice': 100000.0,
  'discountAmount': 0.0,
  'shippingFee': 15000.0,
  'totalPrice': 115000.0,
  'notes': 'warm',
  'items': [orderItem],
  'createdAt': '2026-09-14T00:00:00.000Z',
  'updatedAt': '2026-09-14T00:00:00.000Z',
  'estimatedDeliveryTime': '2026-09-14T01:00:00.000Z',
  'shipperId': 9,
  'cancelReason': null,
  'restaurantId': 201,
  'restaurantName': 'Kitchen',
  'restaurantAddress': 'Shop',
  'restaurantPhone': '0900000002',
  'restaurantLat': 10.77,
  'restaurantLng': 106.7,
  'pickupLat': 10.77,
  'pickupLng': 106.7,
};

void main() {
  test(
    'order and request JSON preserve every field and exclude header identity',
    () {
      final dto = CreateOrderRequestDto.fromJson(body);
      final json = dto.copyWith(idempotencyKey: 'checkout-1').toJson();
      json['items'] = dto.items.map((i) => i.toJson()).toList();
      expect(json, body);
      expect(dto.idempotencyKey, isNull);
      expect(
        OrderDto.fromJson(order).toJson()
          ..['items'] = [OrderItemDto.fromJson(orderItem).toJson()],
        order,
      );
      final entity = OrderDto.fromJson(order).toEntity();
      expect(entity.totalAmount, 115000);
      expect(entity.restaurantLat, 10.77);
      expect(entity.items.single.notes, 'hot');
    },
  );

  final operations = <String, (String, String)>{
    'list': ('GET', '/orders/my-orders'),
    'get': ('GET', '/orders/601'),
    'create': ('POST', '/orders'),
    'cancel': ('PUT', '/orders/601/cancel'),
  };
  for (final entry in operations.entries) {
    for (final scenario in [
      'success',
      'rejected',
      'missing',
      'malformed',
      '400',
      '401',
      '404',
      '500',
      'timeout',
      'conflict',
    ]) {
      test(
        '${entry.key} handles $scenario through the HTTP pipeline',
        () async {
          final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
          final adapter = DioAdapter(dio: dio);
          RequestOptions? sent;
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) {
                sent = options;
                if (scenario == 'timeout') {
                  handler.reject(
                    DioException(
                      requestOptions: options,
                      type: DioExceptionType.connectionTimeout,
                    ),
                  );
                } else {
                  handler.next(options);
                }
              },
            ),
          );
          final (method, path) = entry.value;
          final data = scenario == 'missing'
              ? null
              : scenario == 'malformed'
              ? 'invalid'
              : entry.key == 'list'
              ? {
                  'items': [order],
                  'page': 2,
                  'size': 5,
                  'totalItems': 11,
                  'totalPages': 3,
                  'hasNext': false,
                }
              : order;
          adapter.onRoute(
            path,
            (server) => server.reply(
              scenario == 'conflict' ? 409 : int.tryParse(scenario) ?? 200,
              {
                'status': scenario == 'rejected' ? 0 : 1,
                'message': 'order response',
                'data': data,
                if (scenario == 'conflict')
                  'error': {
                    'code': 'QUOTE_EXPIRED',
                    'details': {'quoteId': command.quoteId},
                  },
              },
            ),
            request: Request(
              method: RequestMethods.forName(name: method),
              queryParameters: entry.key == 'list'
                  ? {'page': 2, 'size': 5}
                  : null,
              data: entry.key == 'create'
                  ? Matchers.any
                  : entry.key == 'cancel'
                  ? {'reason': 'changed mind'}
                  : null,
            ),
          );
          final repository = OrderRepositoryImpl(
            OrderRemoteDataSourceImpl(OrderApiService(dio)),
          );
          final result = switch (entry.key) {
            'list' => await repository.getUserOrders(page: 2, size: 5),
            'get' => await repository.getOrderById(601),
            'create' => await repository.createOrder(command),
            _ => await repository.cancelOrder(601, reason: 'changed mind'),
          };
          expect(sent?.method, method);
          expect(sent?.uri.path, '/api$path');
          expect(
            sent?.queryParameters,
            entry.key == 'list' ? {'page': 2, 'size': 5} : isEmpty,
          );
          if (entry.key == 'create') {
            expect(jsonDecode(jsonEncode(sent?.data)), body);
            expect(sent?.headers['Idempotency-Key'], 'checkout-1');
          }
          if (entry.key == 'cancel') {
            expect(sent?.data, {'reason': 'changed mind'});
          }
          if (scenario == 'success' ||
              (entry.key == 'cancel' && scenario == 'missing')) {
            expect(result.isRight(), isTrue);
            result.fold((e) => fail('$e'), (entity) {
              if (entry.key == 'cancel') {
                expect(entity, isTrue);
              } else if (entry.key == 'list') {
                expect((entity as List).length, 1);
              } else {
                expect((entity as dynamic).id, 601);
              }
            });
          } else {
            final failure = result.fold((e) => e, (_) => null);
            expect(failure, isNotNull);
            if (scenario == 'timeout') expect(failure, isA<NetworkFailure>());
            if (scenario == '401') expect(failure, isA<UnauthorizedFailure>());
            if (['400', '404', '500'].contains(scenario)) {
              expect(failure, isA<ServerFailure>());
            }
            if (['rejected', 'missing', 'malformed'].contains(scenario)) {
              expect(failure, isA<ValidationFailure>());
            }
            if (scenario == 'conflict' && entry.key == 'create') {
              expect(failure, isA<ConflictFailure>());
              expect((failure as ConflictFailure).code, 'QUOTE_EXPIRED');
              expect(failure.details, {'quoteId': command.quoteId});
            }
          }
          dio.close();
        },
      );
    }
    test('${entry.key} handles non-Exception source errors', () async {
      final repository = OrderRepositoryImpl(_BrokenSource());
      final result = switch (entry.key) {
        'list' => await repository.getUserOrders(),
        'get' => await repository.getOrderById(601),
        'create' => await repository.createOrder(command),
        _ => await repository.cancelOrder(601),
      };
      expect(result.fold((e) => e, (_) => null), isA<ServerFailure>());
    });
  }
}

class _BrokenSource implements OrderRemoteDataSource {
  Never broken() => throw StateError('broken');
  @override
  Future<PageDto<OrderDto>> getUserOrders(int page, int size) async => broken();
  @override
  Future<OrderDto> getOrderById(num orderId) async => broken();
  @override
  Future<OrderDto> createOrderWithDto(CreateOrderRequestDto request) async =>
      broken();
  @override
  Future<bool> cancelOrder(int orderId, {String? reason}) async => broken();
}
