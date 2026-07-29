import 'package:delivery_app/features/orders/data/datasources/order_api_service.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late OrderApiService service;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    service = OrderApiService(dio);
  });

  test('reads user orders through canonical /api/orders/my-orders path', () async {
    adapter.onGet(
      '/orders/my-orders',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'items': [
            {
              'id': 101,
              'status': 'PENDING',
              'customerName': 'Khách Test',
              'customerPhone': '0900000001',
              'deliveryAddress': '123 Lê Lợi',
              'paymentMethod': 'COD',
              'subtotalPrice': 100000,
              'discountAmount': 0,
              'shippingFee': 15000,
              'totalPrice': 115000,
              'notes': null,
              'items': [
                {
                  'id': 1001,
                  'menuItemId': 1,
                  'menuItemName': 'Phở bò',
                  'quantity': 1,
                  'price': 100000,
                  'notes': null,
                },
              ],
              'createdAt': '2026-07-29T00:00:00.000Z',
              'updatedAt': '2026-07-29T00:00:00.000Z',
              'estimatedDeliveryTime': null,
              'shipperId': null,
              'cancelReason': null,
              'restaurantId': 11,
              'restaurantName': 'Phở Test',
              'restaurantAddress': '1 Lê Lợi',
              'restaurantPhone': '0900000009',
              'restaurantLat': 10.77,
              'restaurantLng': 106.7,
              'pickupLat': 10.77,
              'pickupLng': 106.7,
            },
          ],
          'page': 0,
          'size': 20,
          'totalItems': 1,
          'totalPages': 1,
          'hasNext': false,
        },
      }),
      queryParameters: {'page': 0, 'size': 20},
    );

    final response = await service.getUserOrders(0, 20);

    expect(response.status, 1);
    expect(response.data?.items, hasLength(1));
    expect(response.data?.items.single.id, 101);
  });

  test('reads order detail through canonical /api/orders path', () async {
    adapter.onGet(
      '/orders/101',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 101,
          'status': 'PENDING',
          'customerName': 'Khách Test',
          'customerPhone': '0900000001',
          'deliveryAddress': '123 Lê Lợi',
          'paymentMethod': 'COD',
          'subtotalPrice': 100000,
          'discountAmount': 0,
          'shippingFee': 15000,
          'totalPrice': 115000,
          'notes': null,
          'items': [
            {
              'id': 1001,
              'menuItemId': 1,
              'menuItemName': 'Phở bò',
              'quantity': 1,
              'price': 100000,
              'notes': null,
            },
          ],
          'createdAt': '2026-07-29T00:00:00.000Z',
          'updatedAt': '2026-07-29T00:00:00.000Z',
          'estimatedDeliveryTime': null,
          'shipperId': null,
          'cancelReason': null,
          'restaurantId': 11,
          'restaurantName': 'Phở Test',
          'restaurantAddress': '1 Lê Lợi',
          'restaurantPhone': '0900000009',
          'restaurantLat': 10.77,
          'restaurantLng': 106.7,
          'pickupLat': 10.77,
          'pickupLng': 106.7,
        },
      }),
    );

    final response = await service.getOrderById(101);

    expect(response.status, 1);
    expect(response.data?.id, 101);
  });

  test('submits checkout preview through canonical /api/orders/checkout-preview path', () async {
    final request = CheckoutPreviewRequest(
      restaurantId: 11,
      deliveryLat: 10.7769,
      deliveryLng: 106.7009,
      couponCode: null,
      items: [
        const CheckoutPreviewItemRequest(menuItemId: 1, quantity: 1),
      ],
    );

    adapter.onPost(
      '/orders/checkout-preview',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'restaurantId': 11,
          'restaurantName': 'Phở Test',
          'items': [
            {
              'menuItemId': 1,
              'menuItemName': 'Phở bò',
              'quantity': 1,
              'unitPrice': 100000,
              'lineTotal': 100000,
            },
          ],
          'subtotal': 100000,
          'shippingFee': 15000,
          'discountAmount': 0,
          'totalPrice': 115000,
          'couponCode': null,
          'couponMessage': null,
          'priceChanges': [],
          'unavailableItemIds': [],
        },
      }),
      data: request,
    );

    final response = await service.checkoutPreview(request);

    expect(response.status, 1);
    expect(response.data?.totalPrice, 115000);
  });

  test('creates and cancels order through canonical /api/orders path', () async {
    final createRequest = CreateOrderRequestDto(
      restaurantId: 11,
      deliveryAddress: '123 Lê Lợi',
      deliveryLat: 10.7769,
      deliveryLng: 106.7009,
      customerName: 'Khách Test',
      customerPhone: '0900000001',
      paymentMethod: 'COD',
      items: [
        const OrderItemRequest(menuItemId: 1, quantity: 1),
      ],
      notes: null,
    );

    adapter.onPost(
      '/orders',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 101,
          'status': 'PENDING',
          'customerName': 'Khách Test',
          'customerPhone': '0900000001',
          'deliveryAddress': '123 Lê Lợi',
          'paymentMethod': 'COD',
          'subtotalPrice': 100000,
          'discountAmount': 0,
          'shippingFee': 15000,
          'totalPrice': 115000,
          'notes': null,
          'items': [
            {
              'id': 1001,
              'menuItemId': 1,
              'menuItemName': 'Phở bò',
              'quantity': 1,
              'price': 100000,
              'notes': null,
            },
          ],
          'createdAt': '2026-07-29T00:00:00.000Z',
          'updatedAt': '2026-07-29T00:00:00.000Z',
          'estimatedDeliveryTime': null,
          'shipperId': null,
          'cancelReason': null,
          'restaurantId': 11,
          'restaurantName': 'Phở Test',
          'restaurantAddress': '1 Lê Lợi',
          'restaurantPhone': '0900000009',
          'restaurantLat': 10.77,
          'restaurantLng': 106.7,
          'pickupLat': 10.77,
          'pickupLng': 106.7,
        },
      }),
      data: createRequest,
    );

    final created = await service.createOrderWithDto(createRequest);
    expect(created.status, 1);
    expect(created.data?.id, 101);

    adapter.onPut(
      '/orders/101/cancel',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 101,
          'status': 'CANCELLED',
          'customerName': 'Khách Test',
          'customerPhone': '0900000001',
          'deliveryAddress': '123 Lê Lợi',
          'paymentMethod': 'COD',
          'subtotalPrice': 100000,
          'discountAmount': 0,
          'shippingFee': 15000,
          'totalPrice': 115000,
          'notes': null,
          'items': [
            {
              'id': 1001,
              'menuItemId': 1,
              'menuItemName': 'Phở bò',
              'quantity': 1,
              'price': 100000,
              'notes': null,
            },
          ],
          'createdAt': '2026-07-29T00:00:00.000Z',
          'updatedAt': '2026-07-29T00:00:00.000Z',
          'estimatedDeliveryTime': null,
          'shipperId': null,
          'cancelReason': 'Changed mind',
          'restaurantId': 11,
          'restaurantName': 'Phở Test',
          'restaurantAddress': '1 Lê Lợi',
          'restaurantPhone': '0900000009',
          'restaurantLat': 10.77,
          'restaurantLng': 106.7,
          'pickupLat': 10.77,
          'pickupLng': 106.7,
        },
      }),
      data: {'reason': 'Changed mind'},
    );

    final cancelled = await service.cancelOrder(101, {'reason': 'Changed mind'});
    expect(cancelled.data?.status, 'CANCELLED');
  });
}
