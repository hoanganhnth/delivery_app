import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_entity.dart';
import 'order_item_dto.dart';

part 'create_order_request_dto.freezed.dart';
part 'create_order_request_dto.g.dart';

@freezed
abstract class CreateOrderRequestDto with _$CreateOrderRequestDto {
  const factory CreateOrderRequestDto({
    required String customerName,
    required String customerPhone,
    required String deliveryAddress,
    required String paymentMethod,
    required double totalAmount,
    String? notes,
    required List<OrderItemDto> items,
  }) = _CreateOrderRequestDto;

  factory CreateOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestDtoFromJson(json);
}

extension CreateOrderRequestDtoX on CreateOrderRequestDto {
  /// Chuyển từ DTO sang Entity để sử dụng trong domain layer
  OrderEntity toEntity() {
    return OrderEntity(
      id: null, // ID sẽ được tạo bởi server
      status: OrderStatus.pending, // Mặc định là pending khi tạo mới
      customerName: customerName,
      customerPhone: customerPhone,
      deliveryAddress: deliveryAddress,
      paymentMethod: PaymentMethod.fromString(paymentMethod),
      totalAmount: totalAmount,
      notes: notes,
      items: items.map((item) => item.toEntity()).toList(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      estimatedDeliveryTime: null,
    );
  }
}

extension OrderEntityToCreateRequestX on OrderEntity {
  /// Chuyển từ Entity sang CreateOrderRequestDto
  CreateOrderRequestDto toCreateRequestDto() {
    return CreateOrderRequestDto(
      customerName: customerName,
      customerPhone: customerPhone,
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod.value,
      totalAmount: totalAmount,
      notes: notes,
      items: items.map((item) => item.toDto()).toList(),
    );
  }
}
