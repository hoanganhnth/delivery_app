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
    switch (value.trim().toUpperCase()) {
      // Nhóm "Đang chờ xử lý"
      case OrderStatusConstants.pending:
      case OrderStatusConstants.pendingPayment:
      case OrderStatusConstants.confirmed:
      case OrderStatusConstants.confirmedByRestaurant:
      case 'READY':
        return OrderStatus.pending;

      // Nhóm "Đang đi giao"
      case OrderStatusConstants.findingShipper:
      case 'WAIT_SHIPPER_CONFIRM':
      case 'ASSIGNED':
      case OrderStatusConstants.assignedToShipper:
      case 'PICKED_UP':
      case OrderStatusConstants.inDelivery:
      case 'IN_PROGRESS':
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
        throw FormatException('Unknown order status: $value');
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
    switch (value.trim().toUpperCase()) {
      case PaymentMethodConstants.cod:
        return PaymentMethod.cod;
      case PaymentMethodConstants.card:
        return PaymentMethod.card;
      case PaymentMethodConstants.wallet:
        return PaymentMethod.wallet;
      default:
        throw FormatException('Unknown payment method: $value');
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
  final double? subtotalPrice;
  final double? discountAmount;
  final double? shippingFee;
  final double totalAmount;
  final String? notes;
  final List<OrderItemEntity> items;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? estimatedDeliveryTime;
  final int? shipperId;
  final String? cancelReason;
  final int? restaurantId;
  final String? restaurantName;
  final String? restaurantAddress;
  final String? restaurantPhone;
  final double? restaurantLat;
  final double? restaurantLng;
  final double? pickupLat;
  final double? pickupLng;

  const OrderEntity({
    this.id,
    required this.status,
    this.rawBackendStatus,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.paymentMethod,
    this.subtotalPrice,
    this.discountAmount,
    this.shippingFee,
    required this.totalAmount,
    this.notes,
    required this.items,
    this.createdAt,
    this.updatedAt,
    this.estimatedDeliveryTime,
    this.shipperId,
    this.cancelReason,
    this.restaurantId,
    this.restaurantName,
    this.restaurantAddress,
    this.restaurantPhone,
    this.restaurantLat,
    this.restaurantLng,
    this.pickupLat,
    this.pickupLng,
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
  bool get canCancel {
    if (status == OrderStatus.pending) return true;
    if (status == OrderStatus.delivering) {
      // Allow cancellation if still finding shipper or just assigned
      return rawBackendStatus == OrderStatusConstants.findingShipper ||
          rawBackendStatus == OrderStatusConstants.assignedToShipper;
    }
    return false;
  }

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
    double? subtotalPrice,
    double? discountAmount,
    double? shippingFee,
    double? totalAmount,
    String? notes,
    List<OrderItemEntity>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? estimatedDeliveryTime,
    int? shipperId,
    String? cancelReason,
    int? restaurantId,
    String? restaurantName,
    String? restaurantAddress,
    String? restaurantPhone,
    double? restaurantLat,
    double? restaurantLng,
    double? pickupLat,
    double? pickupLng,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      rawBackendStatus: rawBackendStatus ?? this.rawBackendStatus,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      subtotalPrice: subtotalPrice ?? this.subtotalPrice,
      discountAmount: discountAmount ?? this.discountAmount,
      shippingFee: shippingFee ?? this.shippingFee,
      totalAmount: totalAmount ?? this.totalAmount,
      notes: notes ?? this.notes,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      shipperId: shipperId ?? this.shipperId,
      cancelReason: cancelReason ?? this.cancelReason,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantAddress: restaurantAddress ?? this.restaurantAddress,
      restaurantPhone: restaurantPhone ?? this.restaurantPhone,
      restaurantLat: restaurantLat ?? this.restaurantLat,
      restaurantLng: restaurantLng ?? this.restaurantLng,
      pickupLat: pickupLat ?? this.pickupLat,
      pickupLng: pickupLng ?? this.pickupLng,
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
    return 'OrderEntity(id: $id, customerName: $customerName, status: $status, totalAmount: $totalAmount, shipperId: $shipperId)';
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
    subtotalPrice,
    discountAmount,
    shippingFee,
    totalAmount,
    notes,
    items,
    createdAt,
    updatedAt,
    estimatedDeliveryTime,
    shipperId,
    cancelReason,
    restaurantId,
    restaurantName,
    restaurantAddress,
    restaurantPhone,
    restaurantLat,
    restaurantLng,
    pickupLat,
    pickupLng,
  ];
}
