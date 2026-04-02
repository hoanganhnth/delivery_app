import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';

/// Local data source interface for IAP data caching
/// Handles only LOCAL storage operations (SharedPreferences, local DB)
/// Used for offline access and caching
abstract class IapLocalDataSource {
  // ============================================================
  // SUBSCRIPTION LOCAL CACHE
  // ============================================================

  /// Get cached subscription tier
  SubscriptionTier getCachedSubscriptionTier();

  /// Save subscription tier to cache
  Future<void> saveSubscriptionTier(SubscriptionTier tier);

  /// Get cached subscription expiry date
  String? getCachedSubscriptionExpiry();

  /// Save subscription expiry date to cache
  Future<void> saveSubscriptionExpiry(String expiryDate);

  /// Clear cached subscription data
  Future<void> clearSubscriptionCache();

  // ============================================================
  // CONSUMABLE LOCAL CACHE
  // ============================================================

  /// Get user credits from local cache
  int getCachedUserCredits();

  /// Save user credits to local cache
  Future<void> saveUserCredits(int balance);

  /// Get user vouchers from local cache
  List<ConsumableDto> getCachedUserVouchers();

  /// Save voucher to local cache
  Future<void> saveVoucher(ConsumableDto voucher);

  /// Remove voucher from local cache
  Future<void> removeVoucher(String voucherId);

  /// Clear all vouchers from cache
  Future<void> clearVouchersCache();

  // ============================================================
  // NON-CONSUMABLE LOCAL CACHE
  // ============================================================

  /// Get unlocked features from local cache
  List<String> getCachedUnlockedFeatures();

  /// Save unlocked feature to local cache
  Future<void> saveUnlockedFeature(String featureId);

  /// Remove unlocked feature from local cache
  Future<void> removeUnlockedFeature(String featureId);

  /// Clear all unlocked features from cache
  Future<void> clearUnlockedFeaturesCache();

  /// Check if feature is unlocked in cache
  bool isFeatureUnlockedInCache(String featureId);

  // ============================================================
  // GENERAL CACHE OPERATIONS
  // ============================================================

  /// Clear all IAP caches
  Future<void> clearAllCache();
}
