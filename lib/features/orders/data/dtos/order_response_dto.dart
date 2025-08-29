import 'package:json_annotation/json_annotation.dart';
import '../../../../core/data/dtos/base_response_dto.dart';

part 'order_response_dto.g.dart';

@JsonSerializable()
class OrderItemDto {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final double totalPrice;

  OrderItemDto({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);
}

@JsonSerializable()
class OrderDto {
  final String id;
  final String userId;
  final String restaurantId;
  final String restaurantName;
  final List<OrderItemDto> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final String status;
  final String? deliveryAddress;
  final String? notes;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'estimated_delivery_time')
  final DateTime? estimatedDeliveryTime;

  OrderDto({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    this.deliveryAddress,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.estimatedDeliveryTime,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}

// Single order response
typedef OrderResponseDto = BaseResponseDto<OrderDto>;

// List of orders response
typedef OrdersListResponseDto = BaseResponseDto<List<OrderDto>>;

// Order creation response (might just return order ID)
@JsonSerializable()
class OrderCreationDataDto {
  final String orderId;
  final String status;

  OrderCreationDataDto({
    required this.orderId,
    required this.status,
  });

  factory OrderCreationDataDto.fromJson(Map<String, dynamic> json) =>
      _$OrderCreationDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreationDataDtoToJson(this);
}

typedef OrderCreationResponseDto = BaseResponseDto<OrderCreationDataDto>;
