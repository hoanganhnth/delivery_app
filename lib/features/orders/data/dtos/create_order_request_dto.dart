import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_request_dto.freezed.dart';
part 'create_order_request_dto.g.dart';

@freezed
abstract class OrderItemRequest with _$OrderItemRequest {
  const factory OrderItemRequest({
    required int menuItemId,
    required String menuItemName,
    required double price,
    required int quantity,
  }) = _OrderItemRequest;

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderItemRequestFromJson(json);
}

@freezed
abstract class CreateOrderRequestDto with _$CreateOrderRequestDto {
  const factory CreateOrderRequestDto({
    required int restaurantId,
    required String restaurantName,
    required String restaurantAddress,
    required String restaurantPhone,
    required String deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    required String customerName,
    required String customerPhone,
    required String paymentMethod, // COD or ONLINE
    String? notes,
    double? pickupLat,
    double? pickupLng,
    required List<OrderItemRequest> items,
  }) = _CreateOrderRequestDto;

  factory CreateOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestDtoFromJson(json);
}
