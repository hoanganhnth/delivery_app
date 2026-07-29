import 'package:delivery_app/features/orders/data/dtos/order_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps server-owned order totals without recalculating fees', () {
    final order = OrderDto.fromJson({
      'id': 17,
      'status': 'CONFIRMED',
      'customerName': 'Khách hàng',
      'customerPhone': '0900000000',
      'deliveryAddress': 'Địa chỉ giao hàng',
      'paymentMethod': 'COD',
      'subtotalPrice': 100000,
      'discountAmount': 5000,
      'shippingFee': 18000,
      'totalPrice': 113000,
      'createdAt': '2026-07-26T10:00:00',
      'restaurantId': 4,
      'restaurantName': 'Quán thật',
      'shipperId': 9,
      'items': <Map<String, dynamic>>[
        {
          'id': 3,
          'menuItemId': 8,
          'menuItemName': 'Cơm gà',
          'quantity': 2,
          'price': 50000,
        },
      ],
    }).toEntity();

    expect(order.subtotalPrice, 100000);
    expect(order.discountAmount, 5000);
    expect(order.shippingFee, 18000);
    expect(order.totalAmount, 113000);
    expect(order.shipperId, 9);
  });

  test('rejects unknown status and non-COD payment instead of defaulting', () {
    Map<String, Object?> payload({
      String status = 'PENDING',
      String paymentMethod = 'COD',
    }) => {
      'id': 17,
      'status': status,
      'customerName': 'Khách hàng',
      'customerPhone': '0900000000',
      'deliveryAddress': 'Địa chỉ giao hàng',
      'paymentMethod': paymentMethod,
      'subtotalPrice': 100000,
      'discountAmount': 0,
      'shippingFee': 18000,
      'totalPrice': 118000,
      'createdAt': '2026-07-26T10:00:00',
      'restaurantId': 4,
      'restaurantName': 'Quán thật',
      'items': <Map<String, dynamic>>[
        {
          'menuItemId': 8,
          'menuItemName': 'Cơm gà',
          'quantity': 2,
          'price': 50000,
        },
      ],
    };

    expect(
      () => OrderDto.fromJson(payload(status: 'UNKNOWN')).toEntity(),
      throwsFormatException,
    );
    expect(
      () => OrderDto.fromJson(payload(paymentMethod: 'MOMO')).toEntity(),
      throwsFormatException,
    );
  });

  test('rejects missing totals and malformed menu items', () {
    final base = <String, Object?>{
      'id': 17,
      'status': 'PENDING',
      'customerName': 'Khách hàng',
      'customerPhone': '0900000000',
      'deliveryAddress': 'Địa chỉ giao hàng',
      'paymentMethod': 'COD',
      'subtotalPrice': 100000,
      'discountAmount': 0,
      'shippingFee': 18000,
      'totalPrice': 118000,
      'createdAt': '2026-07-26T10:00:00',
      'restaurantId': 4,
      'restaurantName': 'Quán thật',
      'items': <Map<String, dynamic>>[
        {
          'menuItemId': 8,
          'menuItemName': 'Cơm gà',
          'quantity': 2,
          'price': 50000,
        },
      ],
    };

    expect(
      () => OrderDto.fromJson({...base, 'totalPrice': null}).toEntity(),
      throwsFormatException,
    );
    expect(
      () => OrderDto.fromJson({
        ...base,
        'items': <Map<String, dynamic>>[
          {
            ...((base['items']! as List).single as Map<String, dynamic>),
            'menuItemId': 0,
          },
        ],
      }).toEntity(),
      throwsFormatException,
    );
  });
}
