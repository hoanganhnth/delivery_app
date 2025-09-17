import 'package:flutter_test/flutter_test.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/order_item_dto.dart';

void main() {
  group('CreateOrderRequestDto Tests', () {
    test('should create CreateOrderRequestDto properly', () {
      // Arrange
      final orderItems = [
        const OrderItemDto(
          id: null,
          menuItemId: 1,
          menuItemName: 'Phở bò',
          price: 50000.0,
          quantity: 2,
        ),
      ];

      // Act
      final createOrderRequest = CreateOrderRequestDto(
        customerName: 'Nguyễn Văn A',
        customerPhone: '0123456789',
        deliveryAddress: '123 Đường ABC, Quận 1, TP.HCM',
        paymentMethod: 'cash',
        totalAmount: 100000.0,
        items: orderItems,
        notes: 'Giao nhanh nhé',
      );

      // Assert
      expect(createOrderRequest.customerName, 'Nguyễn Văn A');
      expect(createOrderRequest.customerPhone, '0123456789');
      expect(createOrderRequest.deliveryAddress, '123 Đường ABC, Quận 1, TP.HCM');
      expect(createOrderRequest.paymentMethod, 'cash');
      expect(createOrderRequest.totalAmount, 100000.0);
      expect(createOrderRequest.items.length, 1);
      expect(createOrderRequest.notes, 'Giao nhanh nhé');
    });

    test('should convert to OrderEntity properly', () {
      // Arrange
      final orderItems = [
        const OrderItemDto(
          id: null,
          menuItemId: 1,
          menuItemName: 'Phở bò',
          price: 50000.0,
          quantity: 2,
        ),
      ];

      final createOrderRequest = CreateOrderRequestDto(
        customerName: 'Nguyễn Văn A',
        customerPhone: '0123456789',
        deliveryAddress: '123 Đường ABC, Quận 1, TP.HCM',
        paymentMethod: 'cash',
        totalAmount: 100000.0,
        items: orderItems,
      );

      // Act
      final orderEntity = createOrderRequest.toEntity();

      // Assert
      expect(orderEntity.customerName, 'Nguyễn Văn A');
      expect(orderEntity.customerPhone, '0123456789');
      expect(orderEntity.deliveryAddress, '123 Đường ABC, Quận 1, TP.HCM');
      expect(orderEntity.totalAmount, 100000.0);
      expect(orderEntity.items.length, 1);
      expect(orderEntity.status.value, 'PENDING');
    });
  });
}
