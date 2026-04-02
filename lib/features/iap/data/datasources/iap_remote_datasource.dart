import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/iap_product_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/non_consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/purchase_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';

/// Remote data source interface for in-app purchases
/// Handles communication with:
/// - App Store / Google Play (via in_app_purchase plugin)
/// - Backend API (for verification and sync)
abstract class IapRemoteDataSource {
  // ============================================================
  // INITIALIZATION & GENERAL
  // ============================================================

  /// Initialize IAP connection with store
  Future<bool> initialize();

  /// Check if IAP is available on this device
  Future<bool> isAvailable();

  /// Get available products from store
  Future<List<IapProductDto>> getProducts(List<String> productIds);

  /// Listen to purchase updates from store
  Stream<List<PurchaseDto>> get purchaseStream;

  /// Dispose resources
  Future<void> dispose();

  // ============================================================
  // PURCHASE OPERATIONS
  // ============================================================

  /// Purchase a product (subscription, consumable, or non-consumable)
  /// Result will be delivered via purchaseStream
  Future<void> buyProduct(String productId);

  /// Restore previous purchases
  /// Restored purchases will be delivered via purchaseStream
  Future<void> restorePurchases();

  /// Complete a pending purchase (mark as delivered)
  Future<void> completePurchase(PurchaseDto purchase);

  /// Verify purchase with backend API
  Future<bool> verifyPurchase(PurchaseDto purchase);

  // ============================================================
  // SUBSCRIPTION OPERATIONS (REMOTE ONLY)
  // ============================================================

  /// Get subscription products from store
  Future<List<IapProductDto>> getSubscriptionProducts();

  /// Get user's active subscription from backend API
  Future<SubscriptionEntity?> getActiveSubscription();

  /// Purchase a subscription (result via purchaseStream)
  Future<void> purchaseSubscription(SubscriptionTier tier);

  // ============================================================
  // CONSUMABLE OPERATIONS (REMOTE ONLY)
  // ============================================================

  /// Get consumable products from backend API
  Future<List<ConsumableDto>> getConsumableProducts();

  /// Purchase a consumable (result via purchaseStream)
  Future<void> purchaseConsumable(String productId);

  /// Get user credits from backend API
  Future<int> getUserCredits();

  /// Get user vouchers from backend API
  Future<List<ConsumableDto>> getUserVouchers();

  // ============================================================
  // NON-CONSUMABLE OPERATIONS (REMOTE ONLY)
  // ============================================================

  /// Get non-consumable products from backend API
  Future<List<NonConsumableDto>> getNonConsumableProducts();

  /// Purchase a non-consumable (result via purchaseStream)
  Future<void> purchaseNonConsumable(String productId);

  /// Get unlocked features from backend API
  Future<List<String>> getUnlockedFeatures();

  /// Check if feature is unlocked via backend API
  Future<bool> isFeatureUnlocked(String featureId);
}
