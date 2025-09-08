import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'cart_item_dto.freezed.dart';
part 'cart_item_dto.g.dart';

/// Cart item DTO for local storage with Hive
@freezed
@HiveType(typeId: 0)
abstract class CartItemDto with _$CartItemDto {
  const factory CartItemDto({
    @HiveField(0) required num menuItemId,
    @HiveField(1) required String menuItemName,
    @HiveField(2) required double price,
    @HiveField(3) required int quantity,
    @HiveField(4) required num restaurantId,
    @HiveField(5) required String restaurantName,
    @HiveField(6) String? imageUrl,
    @HiveField(7) String? notes,
  }) = _CartItemDto;

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);
}
