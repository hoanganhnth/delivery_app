import 'package:freezed_annotation/freezed_annotation.dart';
import 'flash_sale_campaign_dto.dart';

part 'flash_sale_item_dto.freezed.dart';
part 'flash_sale_item_dto.g.dart';

/// DTO cho Flash Sale Item (data layer — serialization)
@freezed
sealed class FlashSaleItemDto with _$FlashSaleItemDto {
  const factory FlashSaleItemDto({
    required int id,
    required FlashSaleCampaignDto campaign,
    required int restaurantId,
    required int menuItemId,
    required String menuItemName,
    required double originalPrice,
    required double flashSalePrice,
    required int stockQuantity,
    required int soldQuantity,
    required String status,
  }) = _FlashSaleItemDto;

  factory FlashSaleItemDto.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleItemDtoFromJson(json);
}
