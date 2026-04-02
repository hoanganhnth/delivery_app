import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';

/// State for non-consumable IAP (unlockable features)
class NonConsumableState {
  final bool isLoading;
  final List<NonConsumableEntity> products;
  final List<FeatureType> unlockedFeatures;
  final Failure? failure;
  final String? successMessage;

  const NonConsumableState({
    this.isLoading = false,
    this.products = const [],
    this.unlockedFeatures = const [],
    this.failure,
    this.successMessage,
  });

  NonConsumableState copyWith({
    bool? isLoading,
    List<NonConsumableEntity>? products,
    List<FeatureType>? unlockedFeatures,
    Failure? failure,
    String? successMessage,
    bool clearFailure = false,
    bool clearSuccessMessage = false,
  }) {
    return NonConsumableState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      unlockedFeatures: unlockedFeatures ?? this.unlockedFeatures,
      failure: clearFailure ? null : (failure ?? this.failure),
      successMessage: clearSuccessMessage
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  /// Check if a specific feature is unlocked
  bool isUnlocked(FeatureType featureType) {
    return unlockedFeatures.contains(featureType);
  }

  /// Get all available features for purchase (not yet unlocked)
  List<NonConsumableEntity> get availableForPurchase =>
      products.where((p) => !p.isUnlocked).toList();

  /// Get all unlocked product entities
  List<NonConsumableEntity> get unlockedProducts =>
      products.where((p) => p.isUnlocked).toList();

  /// Get popular features
  List<NonConsumableEntity> get popularProducts => products
      .where((p) =>
          NonConsumableProducts.popularFeatures.contains(p.featureType))
      .toList();

  /// Get premium features
  List<NonConsumableEntity> get premiumProducts => products
      .where((p) =>
          NonConsumableProducts.premiumFeatures.contains(p.featureType))
      .toList();
}
