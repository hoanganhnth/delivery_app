import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'order_item_entity.dart';

/// Order status enum
enum OrderStatus {
  pending('PENDING'),
  delivering('DELIVERING'),
  cancelled('CANCELLED'),
  delivered('DELIVERED');

  const OrderStatus(this.value);
  final String value;

  /// Chuyển đổi từ string thành enum
  static OrderStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PENDING':
        return OrderStatus.pending;
      case 'DELIVERING':
        return OrderStatus.delivering;
      case 'DELIVERED':
        return OrderStatus.delivered;
      case 'CANCELLED':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending; // Default fallback
    }
  }

  /// Lấy tên tiếng Việt của trạng thái
  String get vietnameseText {
    switch (this) {
      case OrderStatus.pending:
        return 'Chờ giao hàng';
      case OrderStatus.delivering:
        return 'Đang giao hàng';
      case OrderStatus.delivered:
        return 'Thành công';
      case OrderStatus.cancelled:
        return 'Đã huỷ';
    }
  }

  /// Màu sắc cho từng trạng thái
  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.delivering:
        return Colors.blue;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}

/// Payment method enum
enum PaymentMethod {
  cash('CASH'),
  card('CARD'),
  wallet('WALLET');

  const PaymentMethod(this.value);
  final String value;

  /// Chuyển đổi từ string thành enum
  static PaymentMethod fromString(String value) {
    switch (value.toUpperCase()) {
      case 'CASH':
        return PaymentMethod.cash;
      case 'CARD':
        return PaymentMethod.card;
      case 'WALLET':
        return PaymentMethod.wallet;
      default:
        return PaymentMethod.cash; // Default fallback
    }
  }

  /// Lấy tên tiếng Việt của phương thức thanh toán
  String get vietnameseText {
    switch (this) {
      case PaymentMethod.cash:
        return 'Tiền mặt';
      case PaymentMethod.card:
        return 'Thẻ ngân hàng';
      case PaymentMethod.wallet:
        return 'Ví điện tử';
    }
  }
}

/// Order entity representing a complete order
class OrderEntity extends Equatable {
  final int? id;
  final OrderStatus status;
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final PaymentMethod paymentMethod;
  final double totalAmount;
  final String? notes;
  final List<OrderItemEntity> items;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? estimatedDeliveryTime;

  const OrderEntity({
    this.id,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.totalAmount,
    this.notes,
    required this.items,
    this.createdAt,
    this.updatedAt,
    this.estimatedDeliveryTime,
  });

  /// Get formatted status text
  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Chờ giao hàng';
      case OrderStatus.delivering:
        return 'Đang giao hàng';
      case OrderStatus.delivered:
        return 'Thành công';
      case OrderStatus.cancelled:
        return 'Đã huỷ';
    }
  }

  /// Get status color
  String get statusColor {
    switch (status) {
      case OrderStatus.pending:
        return '#FF9800'; // Orange
      case OrderStatus.delivering:
        return '#2196F3'; // Blue
      case OrderStatus.delivered:
        return '#4CAF50'; // Green
      case OrderStatus.cancelled:
        return '#F44336'; // Red
    }
  }

  /// Check if order can be cancelled
  bool get canCancel => status == OrderStatus.pending;

  /// Get total items count
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  /// Get payment method display text
  String get paymentMethodText {
    switch (paymentMethod) {
      case PaymentMethod.cash:
        return 'Tiền mặt';
      case PaymentMethod.card:
        return 'Thẻ tín dụng';
      case PaymentMethod.wallet:
        return 'Ví điện tử';
    }
  }

  /// Tạo bản copy với các thay đổi
  OrderEntity copyWith({
    int? id,
    OrderStatus? status,
    String? customerName,
    String? customerPhone,
    String? deliveryAddress,
    PaymentMethod? paymentMethod,
    double? totalAmount,
    String? notes,
    List<OrderItemEntity>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? estimatedDeliveryTime,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      notes: notes ?? this.notes,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'OrderEntity(id: $id, customerName: $customerName, status: $status, totalAmount: $totalAmount)';
  }
  
  @override
  List<Object?> get props => [
    id,
    status,
    customerName,
    customerPhone,
    deliveryAddress,
    paymentMethod,
    totalAmount,
    notes,
    items,
    createdAt,
    updatedAt,
    estimatedDeliveryTime,
  ];
}
