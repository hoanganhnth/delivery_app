import 'package:freezed_annotation/freezed_annotation.dart';

part 'flash_sale_model.freezed.dart';
part 'flash_sale_model.g.dart';

@freezed
sealed class FlashSaleCampaign with _$FlashSaleCampaign {
  const factory FlashSaleCampaign({
    required int id,
    required String name,
    required bool isRecurring,
    required String startTime,
    required String endTime,
  }) = _FlashSaleCampaign;

  factory FlashSaleCampaign.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleCampaignFromJson(json);
}

@freezed
sealed class FlashSaleItem with _$FlashSaleItem {
  const factory FlashSaleItem({
    required int id,
    required FlashSaleCampaign campaign,
    required int restaurantId,
    required int menuItemId,
    required String menuItemName,
    required double originalPrice,
    required double flashSalePrice,
    required int stockQuantity,
    required int soldQuantity,
    required String status,
  }) = _FlashSaleItem;

  const FlashSaleItem._();

  factory FlashSaleItem.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleItemFromJson(json);

  bool get isSoldOut => soldQuantity >= stockQuantity;
  double get progress => stockQuantity > 0 ? soldQuantity / stockQuantity : 0;
}
