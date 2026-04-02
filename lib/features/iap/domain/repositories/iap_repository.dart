import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:fpdart/fpdart.dart';

/// Repository interface for in-app purchases
abstract class IapRepository {
  // ============================================================
  // INITIALIZATION & GENERAL
  // ============================================================

  /// Initialize the in-app purchase connection
  Future<Either<Failure, bool>> initialize();

  /// Get available products for purchase
  Future<Either<Failure, List<IapProductEntity>>> getProducts(
    List<String> productIds,
  );

  /// Listen to purchase updates
  Stream<List<PurchaseEntity>> get purchaseStream;

  /// Dispose resources
  Future<void> dispose();

  // ============================================================
  // SUBSCRIPTION IAP
  // ============================================================

  /// Get available subscription tiers
  Future<Either<Failure, List<SubscriptionEntity>>> getSubscriptionTiers();

  /// Purchase a subscription
  /// Note: Result will come via purchaseStream, not the return value
  Future<Either<Failure, void>> purchaseSubscription(
    SubscriptionTier tier,
  );

  /// Check if user has active subscription
  Future<Either<Failure, bool>> hasActiveSubscription();

  /// Get current active subscription
  Future<Either<Failure, SubscriptionEntity?>> getActiveSubscription();

  /// Restore previous purchases (subscriptions and non-consumables)
  /// Note: Results will come via purchaseStream, not the return value
  Future<Either<Failure, void>> restorePurchases();

  /// Complete a pending purchase
  Future<Either<Failure, void>> completePurchase(PurchaseEntity purchase);

  // ============================================================
  // CONSUMABLE IAP
  // ============================================================

  /// Get available consumable products
  Future<Either<Failure, List<ConsumableEntity>>> getConsumableProducts();

  /// Purchase a consumable product
  /// Note: Result will come via purchaseStream, not the return value
  Future<Either<Failure, void>> purchaseConsumable(String productId);

  /// Get user's current credits balance
  Future<Either<Failure, int>> getUserCredits();

  /// Add credits to user's balance (after successful purchase)
  Future<Either<Failure, int>> addCredits(int amount);

  /// Deduct credits from user's balance (when using credits)
  Future<Either<Failure, int>> deductCredits(int amount);

  /// Get user's voucher inventory
  Future<Either<Failure, List<ConsumableEntity>>> getUserVouchers();

  /// Add voucher to user's inventory
  Future<Either<Failure, void>> addVoucher(ConsumableEntity voucher);

  /// Use a voucher
  Future<Either<Failure, void>> useVoucher(String voucherId);

  // ============================================================
  // NON-CONSUMABLE IAP
  // ============================================================

  /// Get available non-consumable products (features to unlock)
  Future<Either<Failure, List<NonConsumableEntity>>> getNonConsumableProducts();

  /// Purchase a non-consumable product (unlock a feature)
  /// Note: Result will come via purchaseStream, not the return value
  Future<Either<Failure, void>> purchaseNonConsumable(
    String productId,
  );

  /// Check if a specific feature is unlocked
  Future<Either<Failure, bool>> isFeatureUnlocked(FeatureType featureType);

  /// Get list of all unlocked features
  Future<Either<Failure, List<FeatureType>>> getUnlockedFeatures();

  /// Unlock a feature (after successful purchase)
  Future<Either<Failure, void>> unlockFeature(FeatureType featureType);
}
