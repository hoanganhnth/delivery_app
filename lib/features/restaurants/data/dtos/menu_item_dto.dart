import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/menu_item_entity.dart';

part 'menu_item_dto.freezed.dart';
part 'menu_item_dto.g.dart';

@freezed
abstract class MenuItemDto with _$MenuItemDto {
  const factory MenuItemDto({
   String? id,
     String? restaurantId,
    required String name,
    required String description,
    required double price,
     String? image,
     required MenuItemStatus status
  }) = _MenuItemDto;

  factory MenuItemDto.fromJson(Map<String, dynamic> json) =>
      _$MenuItemDtoFromJson(json);
}

extension MenuItemDtoX on MenuItemDto {
  MenuItemEntity toEntity() {
    return MenuItemEntity(
      id: id,
      restaurantId: restaurantId,
      name: name,
      description: description,
      price: price,
      image: image,
      status: status,
      
      // category: category,
      // isAvailable: isAvailable,
      // allergens: allergens,
      // preparationTime: preparationTime,
      // discount: discount,
      // calories: calories,
      // nutrition: nutrition,
    );
  }
}
