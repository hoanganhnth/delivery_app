import 'package:flutter_test/flutter_test.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';

void main() {
  group('CreateOrderRequestDto Tests', () {
    test('should create CreateOrderRequestDto properly', () {
      // Arrange
      final orderItems = [
        const OrderItemRequest(
          menuItemId: 1,
          menuItemName: 'Phở bò',
          price: 50000.0,
          quantity: 2,
        ),
      ];

      // Act
      final createOrderRequest = CreateOrderRequestDto(
        restaurantId: 1,
        restaurantName: 'Nhà hàng Phở',
        restaurantAddress: '123 Đường ABC',
        restaurantPhone: '0901234567',
        deliveryAddress: '456 Đường XYZ, Quận 1, TP.HCM',
        customerName: 'Nguyễn Văn A',
        customerPhone: '0123456789',
        paymentMethod: 'COD',
        notes: 'Giao nhanh nhé',
        items: orderItems,
      );

      // Assert
      expect(createOrderRequest.restaurantId, 1);
      expect(createOrderRequest.restaurantName, 'Nhà hàng Phở');
      expect(createOrderRequest.customerName, 'Nguyễn Văn A');
      expect(createOrderRequest.customerPhone, '0123456789');
      expect(createOrderRequest.deliveryAddress, '456 Đường XYZ, Quận 1, TP.HCM');
      expect(createOrderRequest.paymentMethod, 'COD');
      expect(createOrderRequest.items.length, 1);
      expect(createOrderRequest.notes, 'Giao nhanh nhé');
    });

    test('should handle optional fields properly', () {
      // Arrange
      final orderItems = [
        const OrderItemRequest(
          menuItemId: 1,
          menuItemName: 'Phở bò',
          price: 50000.0,
          quantity: 1,
        ),
      ];

      // Act
      final createOrderRequest = CreateOrderRequestDto(
        restaurantId: 1,
        restaurantName: 'Nhà hàng Phở',
        restaurantAddress: '123 Đường ABC',
        restaurantPhone: '0901234567',
        deliveryAddress: '456 Đường XYZ',
        customerName: 'Nguyễn Văn A',
        customerPhone: '0123456789',
        paymentMethod: 'ONLINE',
        items: orderItems,
        // Optional fields are null
      );

      // Assert
      expect(createOrderRequest.deliveryLat, isNull);
      expect(createOrderRequest.deliveryLng, isNull);
      expect(createOrderRequest.notes, isNull);
      expect(createOrderRequest.pickupLat, isNull);
      expect(createOrderRequest.pickupLng, isNull);
    });
  });
}
