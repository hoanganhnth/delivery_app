import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'order_item_entity.dart';
import '../../../../core/constants/order_constants.dart';

/// Order status enum
enum OrderStatus {
  pending(OrderStatusConstants.pending),
  delivering(OrderStatusConstants.delivering),
  cancelled(OrderStatusConstants.cancelled),
  delivered(OrderStatusConstants.delivered);

  const OrderStatus(this.value);
  final String value;

  /// Chuyển đổi từ string thành enum
  static OrderStatus fromString(String value) {
    switch (value.toUpperCase()) {
      // Nhóm "Đang chờ xử lý"
      case OrderStatusConstants.pending:
      case OrderStatusConstants.pendingPayment:
      case OrderStatusConstants.confirmed:
      case OrderStatusConstants.confirmedByRestaurant:      
        return OrderStatus.pending;
        
      // Nhóm "Đang đi giao"
      case OrderStatusConstants.findingShipper:
      case OrderStatusConstants.assignedToShipper:
      case OrderStatusConstants.inDelivery:
      case OrderStatusConstants.delivering:
        return OrderStatus.delivering;
        
      // Nhóm "Thành công"
      case OrderStatusConstants.delivered:
        return OrderStatus.delivered;
        
      // Nhóm "Hủy/Lỗi"
      case OrderStatusConstants.cancelled:
      case OrderStatusConstants.paymentFailed:
      case OrderStatusConstants.rejectedByRestaurant:
      case OrderStatusConstants.shipperNotFound:
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
  cod(PaymentMethodConstants.cod),
  card(PaymentMethodConstants.card),
  wallet(PaymentMethodConstants.wallet);

  const PaymentMethod(this.value);
  final String value;

  /// Chuyển đổi từ string thành enum
  static PaymentMethod fromString(String value) {
    switch (value.toUpperCase()) {
      case PaymentMethodConstants.cod:
        return PaymentMethod.cod;
      case PaymentMethodConstants.card:
        return PaymentMethod.card;
      case PaymentMethodConstants.wallet:
        return PaymentMethod.wallet;
      default:
        return PaymentMethod.cod; // Default fallback
    }
  }

  /// Lấy tên tiếng Việt của phương thức thanh toán
  String get vietnameseText {
    switch (this) {
      case PaymentMethod.cod:
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
  final String? rawBackendStatus; // Trạng thái chi tiết từ backend
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
    this.rawBackendStatus,
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

  bool get canTrackingRealtime =>
      id != null &&
      status != OrderStatus.cancelled &&
      status != OrderStatus.delivered;

  /// Check if order can be cancelled
  bool get canCancel => status == OrderStatus.pending;

  /// Get total items count
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  /// Get payment method display text
  String get paymentMethodText {
    switch (paymentMethod) {
      case PaymentMethod.cod:
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
    String? rawBackendStatus,
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
      rawBackendStatus: rawBackendStatus ?? this.rawBackendStatus,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      notes: notes ?? this.notes,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
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
    rawBackendStatus,
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
