import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/iap_product_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/non_consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/purchase_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';

/// Remote data source interface for in-app purchases
abstract class IapRemoteDataSource {
  // ============================================================
  // INITIALIZATION & GENERAL
  // ============================================================

  /// Initialize IAP connection
  Future<bool> initialize();

  /// Get available products
  Future<List<IapProductDto>> getProducts(List<String> productIds);

  /// Listen to purchase updates
  Stream<List<PurchaseDto>> get purchaseStream;

  /// Dispose resources
  Future<void> dispose();

  // ============================================================
  // SUBSCRIPTION IAP
  // ============================================================

  /// Get subscription tiers
  Future<List<IapProductDto>> getSubscriptionProducts();

  /// Purchase a subscription
  Future<PurchaseDto> purchaseSubscription(SubscriptionTier tier);

  /// Restore purchases
  Future<List<PurchaseDto>> restorePurchases();

  /// Complete a pending purchase
  Future<void> completePurchase(PurchaseDto purchase);

  // ============================================================
  // CONSUMABLE IAP
  // ============================================================

  /// Get available consumable products
  Future<List<ConsumableDto>> getConsumableProducts();

  /// Purchase a consumable product
  Future<PurchaseDto> purchaseConsumable(String productId);

  /// Get user credits balance from local storage
  Future<int> getUserCredits();

  /// Save user credits to local storage
  Future<void> saveUserCredits(int balance);

  /// Get user vouchers from local storage
  Future<List<ConsumableDto>> getUserVouchers();

  /// Save voucher to local storage
  Future<void> saveVoucher(ConsumableDto voucher);

  /// Remove voucher from local storage
  Future<void> removeVoucher(String voucherId);

  // ============================================================
  // NON-CONSUMABLE IAP
  // ============================================================

  /// Get available non-consumable products
  Future<List<NonConsumableDto>> getNonConsumableProducts();

  /// Purchase a non-consumable product
  Future<PurchaseDto> purchaseNonConsumable(String productId);

  /// Get unlocked features from local storage
  Future<List<FeatureType>> getUnlockedFeatures();

  /// Save unlocked feature to local storage
  Future<void> saveUnlockedFeature(FeatureType featureType);

  /// Check if a feature is unlocked
  Future<bool> isFeatureUnlocked(FeatureType featureType);
}
