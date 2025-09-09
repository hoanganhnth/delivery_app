import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_entity.dart';
import 'order_item_dto.dart';

part 'order_dto.freezed.dart';
part 'order_dto.g.dart';

@freezed
abstract class OrderDto with _$OrderDto {
  const factory OrderDto({
    int? id,
    required String status,
    required String customerName,
    required String customerPhone,
    required String deliveryAddress,
    required String paymentMethod,
    double? totalAmount,
    String? notes,
    List<OrderItemDto>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? estimatedDeliveryTime,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);
}

extension OrderDtoX on OrderDto {
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      status: OrderStatus.fromString(status),
      customerName: customerName,
      customerPhone: customerPhone,
      deliveryAddress: deliveryAddress,
      paymentMethod: PaymentMethod.fromString(paymentMethod),
      totalAmount: totalAmount ?? 0.0,
      notes: notes,
      items: items?.map((item) => item.toEntity()).toList() ?? [],
      createdAt: createdAt,
      updatedAt: updatedAt,
      estimatedDeliveryTime: estimatedDeliveryTime,
    );
  }
}

extension OrderEntityX on OrderEntity {
  OrderDto toDto() {
    return OrderDto(
      id: id,
      status: status.value,
      customerName: customerName,
      customerPhone: customerPhone,
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod.value,
      totalAmount: totalAmount,
      notes: notes,
      items: items.map((item) => item.toDto()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      estimatedDeliveryTime: estimatedDeliveryTime,
    );
  }
}
