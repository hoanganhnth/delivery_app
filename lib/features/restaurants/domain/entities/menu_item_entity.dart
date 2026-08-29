import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delivery_app/core/contracts/cart_contract.dart';

part 'menu_item_entity.freezed.dart';
part 'menu_item_entity.g.dart';

@freezed
sealed class MenuItemEntity with _$MenuItemEntity implements CartLineSource {
  const factory MenuItemEntity({
    num? id,
    num? restaurantId,
    required String name,
    required String description,
    required double price,
    String? image,
    @MenuItemStatusConverter() required MenuItemStatus status,
  }) = _MenuItemEntity;

  // ignore: unused_element
  const MenuItemEntity._();

  factory MenuItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MenuItemEntityFromJson(json);

  @override
  bool get canAddToCart =>
      status == MenuItemStatus.available &&
      id != null &&
      id! > 0 &&
      restaurantId != null &&
      restaurantId! > 0 &&
      name.trim().isNotEmpty &&
      price > 0;
}

enum MenuItemStatus { available, unavailable, soldOut }

/// Extension methods for MenuItemEntity to work with Cart
extension MenuItemPresentationExtension on MenuItemEntity {
  /// Get display status text
  String get statusDisplayText {
    switch (status) {
      case MenuItemStatus.available:
        return 'Available';
      case MenuItemStatus.unavailable:
        return 'Unavailable';
      case MenuItemStatus.soldOut:
        return 'Sold Out';
    }
  }
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
