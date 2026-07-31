import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_request_dto.freezed.dart';
part 'create_order_request_dto.g.dart';

@freezed
sealed class OrderItemRequest with _$OrderItemRequest {
  const factory OrderItemRequest({
    required int menuItemId,
    required int quantity,
    String? notes,
    int? flashSaleItemId,
  }) = _OrderItemRequest;

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderItemRequestFromJson(json);
}

@freezed
sealed class CreateOrderRequestDto with _$CreateOrderRequestDto {
  const factory CreateOrderRequestDto({
    required int restaurantId,
    required String deliveryAddress,
    required double deliveryLat,
    required double deliveryLng,
    required String customerName,
    required String customerPhone,
    required String paymentMethod, // COD-only in the current MVP
    String? notes,
    List<int>? voucherIds,
    required List<OrderItemRequest> items,
  }) = _CreateOrderRequestDto;

  factory CreateOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestDtoFromJson(json);
}
