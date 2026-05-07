import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';

part 'non_consumable_state.freezed.dart';

/// State for non-consumable IAP (unlockable features)
@freezed
sealed class NonConsumableState with _$NonConsumableState {
  const NonConsumableState._();

  const factory NonConsumableState({
    @Default(false) bool isLoading,
    @Default([]) List<NonConsumableEntity> products,
    @Default([]) List<FeatureType> unlockedFeatures,
    Failure? failure,
    String? successMessage,
  }) = _NonConsumableState;

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
