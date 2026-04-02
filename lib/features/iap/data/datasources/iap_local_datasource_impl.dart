import 'dart:convert';

import 'package:delivery_app/features/iap/data/datasources/iap_local_datasource.dart';
import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Storage keys for local IAP data
class _IapStorageKeys {
  static const String subscriptionTier = 'iap_subscription_tier';
  static const String subscriptionExpiry = 'iap_subscription_expiry';
  static const String userCredits = 'iap_user_credits';
  static const String userVouchers = 'iap_user_vouchers';
  static const String unlockedFeatures = 'iap_unlocked_features';
}

/// Implementation of IAP local data source using SharedPreferences
class IapLocalDataSourceImpl implements IapLocalDataSource {
  final SharedPreferences _prefs;

  IapLocalDataSourceImpl(this._prefs);

  // ============================================================
  // SUBSCRIPTION LOCAL CACHE
  // ============================================================

  @override
  SubscriptionTier getCachedSubscriptionTier() {
    final tierName = _prefs.getString(_IapStorageKeys.subscriptionTier);
    if (tierName == null) {
      return SubscriptionTier.free;
    }

    return SubscriptionTier.values.firstWhere(
      (tier) => tier.name == tierName,
      orElse: () => SubscriptionTier.free,
    );
  }

  @override
  Future<void> saveSubscriptionTier(SubscriptionTier tier) async {
    await _prefs.setString(_IapStorageKeys.subscriptionTier, tier.name);
  }

  @override
  String? getCachedSubscriptionExpiry() {
    return _prefs.getString(_IapStorageKeys.subscriptionExpiry);
  }

  @override
  Future<void> saveSubscriptionExpiry(String expiryDate) async {
    await _prefs.setString(_IapStorageKeys.subscriptionExpiry, expiryDate);
  }

  @override
  Future<void> clearSubscriptionCache() async {
    await _prefs.remove(_IapStorageKeys.subscriptionTier);
    await _prefs.remove(_IapStorageKeys.subscriptionExpiry);
  }

  // ============================================================
  // CONSUMABLE LOCAL CACHE
  // ============================================================

  @override
  int getCachedUserCredits() {
    return _prefs.getInt(_IapStorageKeys.userCredits) ?? 0;
  }

  @override
  Future<void> saveUserCredits(int balance) async {
    await _prefs.setInt(_IapStorageKeys.userCredits, balance);
  }

  @override
  List<ConsumableDto> getCachedUserVouchers() {
    final jsonList = _prefs.getStringList(_IapStorageKeys.userVouchers) ?? [];
    return jsonList
        .map((json) => ConsumableDto.fromJson(jsonDecode(json) as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveVoucher(ConsumableDto voucher) async {
    final cached = getCachedUserVouchers();
    
    // Check if voucher already exists
    final exists = cached.any((v) => v.productId == voucher.productId && v.code == voucher.code);
    if (exists) {
      return; // Don't duplicate
    }

    cached.add(voucher);
    final jsonList = cached.map((v) => jsonEncode(v.toJson())).toList();
    await _prefs.setStringList(_IapStorageKeys.userVouchers, jsonList);
  }

  @override
  Future<void> removeVoucher(String voucherId) async {
    final cached = getCachedUserVouchers();
    // voucherId could be productId or code
    final updated = cached.where((v) => v.productId != voucherId && v.code != voucherId).toList();
    final jsonList = updated.map((v) => jsonEncode(v.toJson())).toList();
    await _prefs.setStringList(_IapStorageKeys.userVouchers, jsonList);
  }

  @override
  Future<void> clearVouchersCache() async {
    await _prefs.remove(_IapStorageKeys.userVouchers);
  }

  // ============================================================
  // NON-CONSUMABLE LOCAL CACHE
  // ============================================================

  @override
  List<String> getCachedUnlockedFeatures() {
    return _prefs.getStringList(_IapStorageKeys.unlockedFeatures) ?? [];
  }

  @override
  Future<void> saveUnlockedFeature(String featureId) async {
    final cached = getCachedUnlockedFeatures();
    
    if (cached.contains(featureId)) {
      return; // Already unlocked
    }

    cached.add(featureId);
    await _prefs.setStringList(_IapStorageKeys.unlockedFeatures, cached);
  }

  @override
  Future<void> removeUnlockedFeature(String featureId) async {
    final cached = getCachedUnlockedFeatures();
    cached.remove(featureId);
    await _prefs.setStringList(_IapStorageKeys.unlockedFeatures, cached);
  }

  @override
  Future<void> clearUnlockedFeaturesCache() async {
    await _prefs.remove(_IapStorageKeys.unlockedFeatures);
  }

  @override
  bool isFeatureUnlockedInCache(String featureId) {
    final cached = getCachedUnlockedFeatures();
    return cached.contains(featureId);
  }

  // ============================================================
  // GENERAL CACHE OPERATIONS
  // ============================================================

  @override
  Future<void> clearAllCache() async {
    await clearSubscriptionCache();
    await clearVouchersCache();
    await clearUnlockedFeaturesCache();
    await _prefs.remove(_IapStorageKeys.userCredits);
  }
}
