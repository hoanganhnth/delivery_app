import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_item_entity.dart';

part 'order_item_dto.freezed.dart';
part 'order_item_dto.g.dart';

@freezed
sealed class OrderItemDto with _$OrderItemDto {
  const factory OrderItemDto({
    int? id,
    required int menuItemId,
    required String menuItemName,
    required int quantity,
    required double price,
    String? notes,
  }) = _OrderItemDto;

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);
}

extension OrderItemDtoX on OrderItemDto {
  OrderItemEntity toEntity() {
    final normalizedName = menuItemName.trim();
    if (menuItemId <= 0 ||
        normalizedName.isEmpty ||
        quantity <= 0 ||
        !price.isFinite ||
        price <= 0) {
      throw const FormatException('Invalid order item contract');
    }
    return OrderItemEntity(
      id: id,
      menuItemId: menuItemId,
      menuItemName: normalizedName,
      quantity: quantity,
      price: price,
      notes: notes,
    );
  }
}
