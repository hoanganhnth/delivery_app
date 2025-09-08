import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';

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

/// Extension methods for MenuItemEntity to work with Cart
extension MenuItemToCartExtension on MenuItemEntity {
  /// Convert this menu item to a cart item
  CartItemEntity toCartItem(
    String restaurantName, {
    int quantity = 1,
    String? notes,
  }) {
    return CartItemEntity.fromMenuItem(
      this,
      restaurantName,
      quantity: quantity,
      notes: notes,
    );
  }

  /// Check if this menu item can be added to cart
  bool get canAddToCart {
    return status == MenuItemStatus.available && id != null;
  }

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