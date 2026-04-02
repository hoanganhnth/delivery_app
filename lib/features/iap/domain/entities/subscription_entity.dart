import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';

/// Entity representing a subscription with additional subscription-specific details
class SubscriptionEntity {
  final IapProductEntity product;
  final bool isActive;
  final String? expiryDate;
  final bool isAutoRenewing;
  final SubscriptionTier tier;

  const SubscriptionEntity({
    required this.product,
    required this.isActive,
    this.expiryDate,
    required this.isAutoRenewing,
    required this.tier,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionEntity &&
          runtimeType == other.runtimeType &&
          product == other.product;

  @override
  int get hashCode => product.hashCode;
}

/// Subscription tier levels for delivery app
enum SubscriptionTier {
  /// Basic free tier
  free,

  /// Premium tier - monthly
  premiumMonthly,

  /// Premium tier - yearly (discounted)
  premiumYearly,

  /// VIP tier - exclusive benefits
  vip,
}

/// Extension to get tier details
extension SubscriptionTierExtension on SubscriptionTier {
  String get displayName {
    switch (this) {
      case SubscriptionTier.free:
        return 'Free';
      case SubscriptionTier.premiumMonthly:
        return 'Premium Monthly';
      case SubscriptionTier.premiumYearly:
        return 'Premium Yearly';
      case SubscriptionTier.vip:
        return 'VIP';
    }
  }

  List<String> get benefits {
    switch (this) {
      case SubscriptionTier.free:
        return [
          'Standard delivery fees',
          'Basic support',
          'Limited order history',
        ];
      case SubscriptionTier.premiumMonthly:
        return [
          'Free delivery on orders over \$20',
          'Priority support',
          'Exclusive deals',
          'Order tracking',
        ];
      case SubscriptionTier.premiumYearly:
        return [
          'Free delivery on all orders',
          '24/7 Priority support',
          'Exclusive deals & early access',
          'Advanced order tracking',
          'Save 20% vs monthly',
        ];
      case SubscriptionTier.vip:
        return [
          'Free express delivery',
          'Dedicated account manager',
          'VIP-only restaurants',
          'Custom meal plans',
          'Birthday rewards',
        ];
    }
  }

  String get productId {
    switch (this) {
      case SubscriptionTier.free:
        return '';
      case SubscriptionTier.premiumMonthly:
        return 'com.delivery.premium.monthly';
      case SubscriptionTier.premiumYearly:
        return 'com.delivery.premium.yearly';
      case SubscriptionTier.vip:
        return 'com.delivery.vip.monthly';
    }
  }
}
