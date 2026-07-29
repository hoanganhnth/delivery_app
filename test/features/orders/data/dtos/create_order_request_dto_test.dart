import 'package:flutter_test/flutter_test.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';

void main() {
  group('CreateOrderRequestDto Tests', () {
    test('should create CreateOrderRequestDto properly', () {
      // Arrange
      final orderItems = [const OrderItemRequest(menuItemId: 1, quantity: 2)];

      // Act
      final createOrderRequest = CreateOrderRequestDto(
        restaurantId: 1,
        deliveryAddress: '456 Đường XYZ, Quận 1, TP.HCM',
        deliveryLat: 10.78,
        deliveryLng: 106.69,
        customerName: 'Nguyễn Văn A',
        customerPhone: '0123456789',
        paymentMethod: 'COD',
        notes: 'Giao nhanh nhé',
        items: orderItems,
      );

      // Assert
      expect(createOrderRequest.restaurantId, 1);
      expect(createOrderRequest.customerName, 'Nguyễn Văn A');
      expect(createOrderRequest.customerPhone, '0123456789');
      expect(
        createOrderRequest.deliveryAddress,
        '456 Đường XYZ, Quận 1, TP.HCM',
      );
      expect(createOrderRequest.paymentMethod, 'COD');
      expect(createOrderRequest.items.length, 1);
      expect(createOrderRequest.notes, 'Giao nhanh nhé');
    });

    test('should handle optional fields properly', () {
      // Arrange
      final orderItems = [const OrderItemRequest(menuItemId: 1, quantity: 1)];

      // Act
      final createOrderRequest = CreateOrderRequestDto(
        restaurantId: 1,
        deliveryAddress: '456 Đường XYZ',
        deliveryLat: 10.78,
        deliveryLng: 106.69,
        customerName: 'Nguyễn Văn A',
        customerPhone: '0123456789',
        paymentMethod: 'COD',
        items: orderItems,
        // Optional fields are null
      );

      // Assert
      expect(createOrderRequest.deliveryLat, 10.78);
      expect(createOrderRequest.deliveryLng, 106.69);
      expect(createOrderRequest.notes, isNull);
      expect(createOrderRequest.items.single.notes, isNull);
    });
  });
}
