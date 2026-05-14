class FlashSaleCampaign {
  final int id;
  final String name;
  final bool isRecurring;
  final String startTime;
  final String endTime;

  FlashSaleCampaign({
    required this.id,
    required this.name,
    required this.isRecurring,
    required this.startTime,
    required this.endTime,
  });

  factory FlashSaleCampaign.fromJson(Map<String, dynamic> json) {
    return FlashSaleCampaign(
      id: json['id'],
      name: json['name'],
      isRecurring: json['isRecurring'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}

class FlashSaleItem {
  final int id;
  final FlashSaleCampaign campaign;
  final int restaurantId;
  final int menuItemId;
  final String menuItemName;
  final double originalPrice;
  final double flashSalePrice;
  final int stockQuantity;
  final int soldQuantity;
  final String status;

  FlashSaleItem({
    required this.id,
    required this.campaign,
    required this.restaurantId,
    required this.menuItemId,
    required this.menuItemName,
    required this.originalPrice,
    required this.flashSalePrice,
    required this.stockQuantity,
    required this.soldQuantity,
    required this.status,
  });

  factory FlashSaleItem.fromJson(Map<String, dynamic> json) {
    return FlashSaleItem(
      id: json['id'],
      campaign: FlashSaleCampaign.fromJson(json['campaign']),
      restaurantId: json['restaurantId'],
      menuItemId: json['menuItemId'],
      menuItemName: json['menuItemName'],
      originalPrice: (json['originalPrice'] as num).toDouble(),
      flashSalePrice: (json['flashSalePrice'] as num).toDouble(),
      stockQuantity: json['stockQuantity'],
      soldQuantity: json['soldQuantity'],
      status: json['status'],
    );
  }

  bool get isSoldOut => soldQuantity >= stockQuantity;
  double get progress => stockQuantity > 0 ? soldQuantity / stockQuantity : 0;
}
