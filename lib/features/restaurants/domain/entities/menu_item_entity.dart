import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_entity.freezed.dart';

@freezed
abstract class MenuItemEntity with _$MenuItemEntity {
  const factory MenuItemEntity(
      {num? id,
      num? restaurantId,
      required String name,
      required String description,
      required double price,
      String? image,
      required MenuItemStatus status
      // required String category,
      // required bool isAvailable,
      // required List<String> allergens,
      // required int preparationTime, // in minutes
      // double? discount,
      // int? calories,
      // Map<String, dynamic>? nutrition,
      }) = _MenuItemEntity;
}

enum MenuItemStatus {
  available,
  unavailable,
  soldOut,
}
