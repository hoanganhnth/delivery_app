import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';

/// Entity representing a non-consumable product (one-time unlock feature)
class NonConsumableEntity {
  final IapProductEntity product;
  final FeatureType featureType;
  final bool isUnlocked;
  final DateTime? purchaseDate;

  const NonConsumableEntity({
    required this.product,
    required this.featureType,
    required this.isUnlocked,
    this.purchaseDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NonConsumableEntity &&
          runtimeType == other.runtimeType &&
          product == other.product;

  @override
  int get hashCode => product.hashCode;
}

/// Types of unlockable features
enum FeatureType {
  /// Remove all ads
  removeAds,

  /// Unlock dark theme
  darkTheme,

  /// Unlock custom themes
  customThemes,

  /// Priority delivery queue
  priorityQueue,

  /// Advanced order tracking with live map
  advancedTracking,

  /// Unlock all restaurants (including premium ones)
  premiumRestaurants,

  /// Custom meal planner feature
  mealPlanner,

  /// Family sharing (share orders with family members)
  familySharing,

  /// Lifetime VIP status
  lifetimeVip,
}

/// Extension for FeatureType
extension FeatureTypeExtension on FeatureType {
  String get displayName {
    switch (this) {
      case FeatureType.removeAds:
        return 'Remove Ads';
      case FeatureType.darkTheme:
        return 'Dark Theme';
      case FeatureType.customThemes:
        return 'Custom Themes';
      case FeatureType.priorityQueue:
        return 'Priority Queue';
      case FeatureType.advancedTracking:
        return 'Advanced Tracking';
      case FeatureType.premiumRestaurants:
        return 'Premium Restaurants';
      case FeatureType.mealPlanner:
        return 'Meal Planner';
      case FeatureType.familySharing:
        return 'Family Sharing';
      case FeatureType.lifetimeVip:
        return 'Lifetime VIP';
    }
  }

  String get description {
    switch (this) {
      case FeatureType.removeAds:
        return 'Enjoy ad-free experience forever';
      case FeatureType.darkTheme:
        return 'Unlock beautiful dark theme';
      case FeatureType.customThemes:
        return 'Access 20+ custom color themes';
      case FeatureType.priorityQueue:
        return 'Your orders get processed first';
      case FeatureType.advancedTracking:
        return 'Live map tracking with ETA updates';
      case FeatureType.premiumRestaurants:
        return 'Access exclusive premium restaurants';
      case FeatureType.mealPlanner:
        return 'Plan your meals for the week';
      case FeatureType.familySharing:
        return 'Share orders with up to 5 family members';
      case FeatureType.lifetimeVip:
        return 'All premium features forever';
    }
  }

  String get icon {
    switch (this) {
      case FeatureType.removeAds:
        return '🚫';
      case FeatureType.darkTheme:
        return '🌙';
      case FeatureType.customThemes:
        return '🎨';
      case FeatureType.priorityQueue:
        return '⚡';
      case FeatureType.advancedTracking:
        return '📍';
      case FeatureType.premiumRestaurants:
        return '👑';
      case FeatureType.mealPlanner:
        return '📅';
      case FeatureType.familySharing:
        return '👨‍👩‍👧‍👦';
      case FeatureType.lifetimeVip:
        return '💎';
    }
  }

  String get productId {
    switch (this) {
      case FeatureType.removeAds:
        return 'com.delivery.feature.remove_ads';
      case FeatureType.darkTheme:
        return 'com.delivery.feature.dark_theme';
      case FeatureType.customThemes:
        return 'com.delivery.feature.custom_themes';
      case FeatureType.priorityQueue:
        return 'com.delivery.feature.priority_queue';
      case FeatureType.advancedTracking:
        return 'com.delivery.feature.advanced_tracking';
      case FeatureType.premiumRestaurants:
        return 'com.delivery.feature.premium_restaurants';
      case FeatureType.mealPlanner:
        return 'com.delivery.feature.meal_planner';
      case FeatureType.familySharing:
        return 'com.delivery.feature.family_sharing';
      case FeatureType.lifetimeVip:
        return 'com.delivery.feature.lifetime_vip';
    }
  }

  static FeatureType? fromProductId(String productId) {
    for (final type in FeatureType.values) {
      if (type.productId == productId) {
        return type;
      }
    }
    return null;
  }
}

/// Predefined non-consumable products
class NonConsumableProducts {
  static List<String> get allProductIds =>
      FeatureType.values.map((f) => f.productId).toList();

  static List<FeatureType> get popularFeatures => [
        FeatureType.removeAds,
        FeatureType.advancedTracking,
        FeatureType.priorityQueue,
      ];

  static List<FeatureType> get premiumFeatures => [
        FeatureType.premiumRestaurants,
        FeatureType.mealPlanner,
        FeatureType.familySharing,
        FeatureType.lifetimeVip,
      ];
}
