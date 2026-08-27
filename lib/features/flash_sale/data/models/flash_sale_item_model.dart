import '../../domain/entities/flash_sale_item_entity.dart';

final class FlashSaleItemModel {
  const FlashSaleItemModel({
    required this.id,
    required this.campaignId,
    required this.restaurantId,
    required this.menuItemId,
    required this.originalPrice,
    required this.flashSalePrice,
    required this.stockQuantity,
    required this.soldQuantity,
    required this.status,
    this.campaignName,
    this.menuItemName,
    this.imageUrl,
  });

  final int id;
  final int campaignId;
  final int restaurantId;
  final int menuItemId;
  final double originalPrice;
  final double flashSalePrice;
  final int stockQuantity;
  final int soldQuantity;
  final String status;
  final String? campaignName;
  final String? menuItemName;
  final String? imageUrl;

  factory FlashSaleItemModel.fromJson(
    Map<String, dynamic> json, {
    required int fallbackCampaignId,
    String? campaignName,
  }) {
    final id = json['id'];
    final rawCampaignId = json['campaignId'] ?? fallbackCampaignId;
    final restaurantId = json['restaurantId'];
    final menuItemId = json['menuItemId'];
    final originalPrice = json['originalPrice'];
    final flashSalePrice = json['flashSalePrice'];
    final stockQuantity = json['stockQuantity'];
    final soldQuantity = json['soldQuantity'];
    final status = json['status'];
    if (id is! num ||
        id.toInt() <= 0 ||
        rawCampaignId is! num ||
        rawCampaignId.toInt() <= 0 ||
        restaurantId is! num ||
        restaurantId.toInt() <= 0 ||
        menuItemId is! num ||
        menuItemId.toInt() <= 0 ||
        originalPrice is! num ||
        !originalPrice.toDouble().isFinite ||
        originalPrice <= 0 ||
        flashSalePrice is! num ||
        !flashSalePrice.toDouble().isFinite ||
        flashSalePrice <= 0 ||
        flashSalePrice >= originalPrice ||
        stockQuantity is! num ||
        stockQuantity.toInt() <= 0 ||
        soldQuantity is! num ||
        soldQuantity.toInt() < 0 ||
        soldQuantity.toInt() > stockQuantity.toInt() ||
        status is! String ||
        status.trim().isEmpty) {
      throw const FormatException('Invalid flash-sale item');
    }
    return FlashSaleItemModel(
      id: id.toInt(),
      campaignId: rawCampaignId.toInt(),
      restaurantId: restaurantId.toInt(),
      menuItemId: menuItemId.toInt(),
      originalPrice: originalPrice.toDouble(),
      flashSalePrice: flashSalePrice.toDouble(),
      stockQuantity: stockQuantity.toInt(),
      soldQuantity: soldQuantity.toInt(),
      status: status.trim().toUpperCase(),
      campaignName: campaignName,
      menuItemName: (json['menuItemName'] as String?)?.trim(),
      imageUrl: (json['imageUrl'] as String?)?.trim(),
    );
  }

  FlashSaleItemEntity toEntity() => FlashSaleItemEntity(
    id: id,
    campaignId: campaignId,
    restaurantId: restaurantId,
    menuItemId: menuItemId,
    originalPrice: originalPrice,
    flashSalePrice: flashSalePrice,
    stockQuantity: stockQuantity,
    soldQuantity: soldQuantity,
    status: status,
    campaignName: campaignName,
    menuItemName: menuItemName,
    imageUrl: imageUrl,
  );
}
