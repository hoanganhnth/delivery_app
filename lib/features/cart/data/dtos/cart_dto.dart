import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'cart_item_dto.dart';

part 'cart_dto.freezed.dart';
part 'cart_dto.g.dart';

/// Cart DTO for local storage with Hive
@freezed
@HiveType(typeId: 1)
abstract class CartDto with _$CartDto {
  const factory CartDto({
    @HiveField(0) required List<CartItemDto> items,
    @HiveField(1) num? currentRestaurantId,
    @HiveField(2) String? currentRestaurantName,
  }) = _CartDto;

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
}
