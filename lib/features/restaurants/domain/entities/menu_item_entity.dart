import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_entity.freezed.dart';

@freezed
abstract class MenuItemEntity with _$MenuItemEntity {
  const factory MenuItemEntity({
    required String id,
    required String restaurantId,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required String category,
    required bool isAvailable,
    required List<String> allergens,
    required int preparationTime, // in minutes
    double? discount,
    int? calories,
    Map<String, dynamic>? nutrition,
  }) = _MenuItemEntity;
}
