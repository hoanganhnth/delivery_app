import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_entity.freezed.dart';
part 'menu_item_entity.g.dart';

@freezed
abstract class MenuItemEntity with _$MenuItemEntity {
  const factory MenuItemEntity({
    num? id,
    num? restaurantId,
    required String name,
    required String description,
    required double price,
    String? image,
   @MenuItemStatusConverter() required MenuItemStatus status,
  }) = _MenuItemEntity;

  factory MenuItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MenuItemEntityFromJson(json);
}

enum MenuItemStatus {
  available,
  unavailable,
  soldOut,
}



class MenuItemStatusConverter implements JsonConverter<MenuItemStatus, String> {
  const MenuItemStatusConverter();

  @override
  MenuItemStatus fromJson(String json) {
    switch (json.toUpperCase()) {
      case 'AVAILABLE':
        return MenuItemStatus.available;
      case 'UNAVAILABLE':
        return MenuItemStatus.unavailable;
      case 'SOLD_OUT':
        return MenuItemStatus.soldOut;
      default:
        throw ArgumentError('Invalid MenuItemStatus: $json');
    }
  }

  @override
  String toJson(MenuItemStatus object) => object.name.toUpperCase();
}