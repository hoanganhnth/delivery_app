/// Entity representing an in-app purchase product
class IapProductEntity {
  final String id;
  final String title;
  final String description;
  final String price;
  final String currencyCode;
  final double rawPrice;
  final IapProductType productType;

  const IapProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.currencyCode,
    required this.rawPrice,
    required this.productType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IapProductEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Type of in-app purchase product
enum IapProductType {
  /// Auto-renewable subscription
  subscription,

  /// Consumable product (can be purchased multiple times)
  consumable,

  /// Non-consumable product (one-time purchase)
  nonConsumable,
}
