import 'package:freezed_annotation/freezed_annotation.dart';

part 'flash_sale_item_entity.freezed.dart';

/// Domain entity cho Flash Sale Item
@freezed
sealed class FlashSaleItemEntity with _$FlashSaleItemEntity {
  const factory FlashSaleItemEntity({
    required int id,
    required int campaignId,
    required String campaignName,
    required int restaurantId,
    required int menuItemId,
    required String menuItemName,
    required double originalPrice,
    required double flashSalePrice,
    required int stockQuantity,
    required int soldQuantity,
    required String status,
  }) = _FlashSaleItemEntity;

  const FlashSaleItemEntity._();

  /// Đã hết suất chưa
  bool get isSoldOut => soldQuantity >= stockQuantity;

  /// Tiến độ bán (0.0 → 1.0)
  double get progress =>
      stockQuantity > 0 ? (soldQuantity / stockQuantity).clamp(0.0, 1.0) : 0;

  /// Phần trăm giảm giá
  int get discountPercent =>
      originalPrice > 0 ? ((1 - flashSalePrice / originalPrice) * 100).round() : 0;

  /// Số lượng còn lại
  int get remainingQuantity => (stockQuantity - soldQuantity).clamp(0, stockQuantity);
}
