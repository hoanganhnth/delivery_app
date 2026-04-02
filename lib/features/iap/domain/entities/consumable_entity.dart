import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';

/// Entity representing a consumable product (voucher, credits, etc.)
class ConsumableEntity {
  final IapProductEntity product;
  final ConsumableType type;
  final double value; // Value in currency or percentage
  final String? code; // Optional voucher code
  final DateTime? expiryDate;

  const ConsumableEntity({
    required this.product,
    required this.type,
    required this.value,
    this.code,
    this.expiryDate,
  });

  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsumableEntity &&
          runtimeType == other.runtimeType &&
          product == other.product;

  @override
  int get hashCode => product.hashCode;
}

/// Types of consumable products
enum ConsumableType {
  /// Discount voucher (percentage off)
  discountVoucher,

  /// Cash voucher (fixed amount off)
  cashVoucher,

  /// Delivery credits
  deliveryCredits,

  /// Reward points
  rewardPoints,

  /// Gift card
  giftCard,
}

/// Extension for ConsumableType
extension ConsumableTypeExtension on ConsumableType {
  String get displayName {
    switch (this) {
      case ConsumableType.discountVoucher:
        return 'Discount Voucher';
      case ConsumableType.cashVoucher:
        return 'Cash Voucher';
      case ConsumableType.deliveryCredits:
        return 'Delivery Credits';
      case ConsumableType.rewardPoints:
        return 'Reward Points';
      case ConsumableType.giftCard:
        return 'Gift Card';
    }
  }

  String get icon {
    switch (this) {
      case ConsumableType.discountVoucher:
        return '🏷️';
      case ConsumableType.cashVoucher:
        return '💵';
      case ConsumableType.deliveryCredits:
        return '🚗';
      case ConsumableType.rewardPoints:
        return '⭐';
      case ConsumableType.giftCard:
        return '🎁';
    }
  }

  String get productIdPrefix {
    switch (this) {
      case ConsumableType.discountVoucher:
        return 'com.delivery.voucher.discount';
      case ConsumableType.cashVoucher:
        return 'com.delivery.voucher.cash';
      case ConsumableType.deliveryCredits:
        return 'com.delivery.credits';
      case ConsumableType.rewardPoints:
        return 'com.delivery.points';
      case ConsumableType.giftCard:
        return 'com.delivery.giftcard';
    }
  }
}

/// Predefined consumable products for delivery app
class ConsumableProducts {
  // Discount Vouchers
  static const String discount10 = 'com.delivery.voucher.discount.10';
  static const String discount20 = 'com.delivery.voucher.discount.20';
  static const String discount30 = 'com.delivery.voucher.discount.30';

  // Cash Vouchers
  static const String cash5 = 'com.delivery.voucher.cash.5';
  static const String cash10 = 'com.delivery.voucher.cash.10';
  static const String cash20 = 'com.delivery.voucher.cash.20';

  // Delivery Credits
  static const String credits50 = 'com.delivery.credits.50';
  static const String credits100 = 'com.delivery.credits.100';
  static const String credits200 = 'com.delivery.credits.200';

  static List<String> get allProductIds => [
        discount10,
        discount20,
        discount30,
        cash5,
        cash10,
        cash20,
        credits50,
        credits100,
        credits200,
      ];

  static ConsumableType getTypeFromProductId(String productId) {
    if (productId.contains('voucher.discount')) {
      return ConsumableType.discountVoucher;
    } else if (productId.contains('voucher.cash')) {
      return ConsumableType.cashVoucher;
    } else if (productId.contains('credits')) {
      return ConsumableType.deliveryCredits;
    } else if (productId.contains('points')) {
      return ConsumableType.rewardPoints;
    } else if (productId.contains('giftcard')) {
      return ConsumableType.giftCard;
    }
    return ConsumableType.cashVoucher;
  }

  static double getValueFromProductId(String productId) {
    // Extract numeric value from product ID
    final parts = productId.split('.');
    final lastPart = parts.last;
    return double.tryParse(lastPart) ?? 0.0;
  }
}
