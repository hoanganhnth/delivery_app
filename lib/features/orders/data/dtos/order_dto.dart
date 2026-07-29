import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_entity.dart';
import 'order_item_dto.dart';

part 'order_dto.freezed.dart';
part 'order_dto.g.dart';

@freezed
sealed class OrderDto with _$OrderDto {
  const factory OrderDto({
    int? id,
    required String status,
    required String customerName,
    required String customerPhone,
    required String deliveryAddress,
    required String paymentMethod,
    double? subtotalPrice,
    double? discountAmount,
    double? shippingFee,
    @JsonKey(name: 'totalPrice') double? totalAmount,
    String? notes,
    List<OrderItemDto>? items,
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
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);
}

extension OrderDtoX on OrderDto {
  OrderEntity toEntity() {
    final orderId = id;
    final currentRestaurantId = restaurantId;
    final normalizedRestaurantName = restaurantName?.trim();
    final normalizedCustomerName = customerName.trim();
    final normalizedCustomerPhone = customerPhone.trim();
    final normalizedDeliveryAddress = deliveryAddress.trim();
    final parsedPaymentMethod = PaymentMethod.fromString(paymentMethod);
    final currentSubtotal = subtotalPrice;
    final currentDiscount = discountAmount;
    final currentShippingFee = shippingFee;
    final currentTotal = totalAmount;
    final currentItems = items;

    if (orderId == null || orderId <= 0) {
      throw const FormatException('Order id must be positive');
    }
    if (currentRestaurantId == null || currentRestaurantId <= 0) {
      throw const FormatException('Restaurant id must be positive');
    }
    if (normalizedRestaurantName == null || normalizedRestaurantName.isEmpty) {
      throw const FormatException('Restaurant name is required');
    }
    if (normalizedCustomerName.isEmpty ||
        normalizedCustomerPhone.isEmpty ||
        normalizedDeliveryAddress.isEmpty) {
      throw const FormatException('Customer delivery identity is required');
    }
    if (parsedPaymentMethod != PaymentMethod.cod) {
      throw const FormatException('Only COD orders are supported in MVP');
    }
    if (!_isNonNegative(currentSubtotal) ||
        !_isNonNegative(currentDiscount) ||
        !_isNonNegative(currentShippingFee) ||
        currentTotal == null ||
        !currentTotal.isFinite ||
        currentTotal <= 0) {
      throw const FormatException('Invalid server-owned order totals');
    }
    if (currentItems == null || currentItems.isEmpty) {
      throw const FormatException('Order items are required');
    }
    if (createdAt == null) {
      throw const FormatException('Order creation timestamp is required');
    }
    if (shipperId != null && shipperId! <= 0) {
      throw const FormatException('Shipper id must be positive when present');
    }

    return OrderEntity(
      id: orderId,
      status: OrderStatus.fromString(status),
      rawBackendStatus: status,
      customerName: normalizedCustomerName,
      customerPhone: normalizedCustomerPhone,
      deliveryAddress: normalizedDeliveryAddress,
      paymentMethod: parsedPaymentMethod,
      subtotalPrice: currentSubtotal,
      discountAmount: currentDiscount,
      shippingFee: currentShippingFee,
      totalAmount: currentTotal,
      notes: notes,
      items: currentItems
          .map((item) => item.toEntity())
          .toList(growable: false),
      createdAt: createdAt,
      updatedAt: updatedAt,
      estimatedDeliveryTime: estimatedDeliveryTime,
      shipperId: shipperId,
      cancelReason: cancelReason,
      restaurantId: currentRestaurantId,
      restaurantName: normalizedRestaurantName,
      restaurantAddress: restaurantAddress,
      restaurantPhone: restaurantPhone,
      restaurantLat: restaurantLat,
      restaurantLng: restaurantLng,
      pickupLat: pickupLat,
      pickupLng: pickupLng,
    );
  }

  static bool _isNonNegative(double? value) {
    return value != null && value.isFinite && value >= 0;
  }
}
