import 'package:equatable/equatable.dart';

/// Server-authoritative Flash Sale inventory line.
final class FlashSaleItemEntity extends Equatable {
  const FlashSaleItemEntity({
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

  bool get isApproved => status.toUpperCase() == 'APPROVED';
  bool get isSoldOut => soldQuantity >= stockQuantity;
  bool get hasStock => stockQuantity > soldQuantity;
  int get remainingQuantity =>
      (stockQuantity - soldQuantity).clamp(0, stockQuantity);
  double get progress =>
      stockQuantity <= 0 ? 0 : (soldQuantity / stockQuantity).clamp(0.0, 1.0);
  int get discountPercent => originalPrice <= 0
      ? 0
      : ((1 - flashSalePrice / originalPrice) * 100).round();
  String get displayName => menuItemName?.trim().isNotEmpty == true
      ? menuItemName!.trim()
      : 'Món #$menuItemId';

  @override
  List<Object?> get props => [
    id,
    campaignId,
    restaurantId,
    menuItemId,
    originalPrice,
    flashSalePrice,
    stockQuantity,
    soldQuantity,
    status,
    campaignName,
    menuItemName,
    imageUrl,
  ];
}
