import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_remote_datasource.dart';
import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IapRepositoryImpl implements IapRepository {
  final IapRemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;

  static const String _activeSubscriptionKey = 'active_subscription_tier';
  static const String _subscriptionExpiryKey = 'subscription_expiry_date';

  IapRepositoryImpl(this._remoteDataSource, this._prefs);

  @override
  Future<Either<Failure, bool>> initialize() async {
    try {
      final result = await _remoteDataSource.initialize();
      return right(result);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<IapProductEntity>>> getProducts(
    List<String> productIds,
  ) async {
    try {
      final products = await _remoteDataSource.getProducts(productIds);
      return right(products.map((dto) => dto.toEntity()).toList());
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionEntity>>> getSubscriptionTiers() async {
    try {
      final products = await _remoteDataSource.getSubscriptionProducts();
      
      // Convert to subscription entities
      final subscriptions = products.map((productDto) {
        final product = productDto.toEntity();
        final tier = _getTierFromProductId(product.id);
        
        // Check if this subscription is currently active
        final activeTier = _getStoredSubscriptionTier();
        final isActive = activeTier == tier;
        
        return SubscriptionEntity(
          product: product,
          isActive: isActive,
          expiryDate: isActive ? _getStoredExpiryDate() : null,
          isAutoRenewing: true, // Default to auto-renewing
          tier: tier,
        );
      }).toList();

      return right(subscriptions);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> purchaseSubscription(
    SubscriptionTier tier,
  ) async {
    try {
      final purchase = await _remoteDataSource.purchaseSubscription(tier);
      
      // Store subscription info locally
      await _storeSubscriptionInfo(tier);
      
      return right(purchase.toEntity());
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseEntity>>> restorePurchases() async {
    try {
      final purchases = await _remoteDataSource.restorePurchases();
      
      // Update stored subscription info based on restored purchases
      for (final purchase in purchases) {
        final tier = _getTierFromProductId(purchase.productId);
        if (tier != SubscriptionTier.free) {
          await _storeSubscriptionInfo(tier);
        }
      }
      
      return right(purchases.map((dto) => dto.toEntity()).toList());
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> completePurchase(PurchaseEntity purchase) async {
    try {
      // Convert entity back to DTO (simplified)
      // In real app, track PurchaseDetails objects
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasActiveSubscription() async {
    try {
      final tier = _getStoredSubscriptionTier();
      
      if (tier == SubscriptionTier.free) {
        return right(false);
      }

      // Check expiry date
      final expiryDate = _getStoredExpiryDate();
      if (expiryDate == null) {
        return right(false);
      }

      final expiry = DateTime.tryParse(expiryDate);
      if (expiry == null || expiry.isBefore(DateTime.now())) {
        // Subscription expired, clear it
        await _clearSubscriptionInfo();
        return right(false);
      }

      return right(true);
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, SubscriptionEntity?>> getActiveSubscription() async {
    try {
      final hasActive = await hasActiveSubscription();
      
      if (hasActive.isLeft() || !hasActive.getOrElse((_) => false)) {
        return right(null);
      }

      final tier = _getStoredSubscriptionTier();
      final expiryDate = _getStoredExpiryDate();

      // Create a subscription entity from stored data
      final subscription = SubscriptionEntity(
        product: IapProductEntity(
          id: tier.productId,
          title: tier.displayName,
          description: tier.benefits.join(', '),
          price: '', // Would need to fetch from store
          currencyCode: 'USD',
          rawPrice: 0.0,
          productType: IapProductType.subscription,
        ),
        isActive: true,
        expiryDate: expiryDate,
        isAutoRenewing: true,
        tier: tier,
      );

      return right(subscription);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Stream<List<PurchaseEntity>> get purchaseStream {
    return _remoteDataSource.purchaseStream.map(
      (purchases) => purchases.map((dto) => dto.toEntity()).toList(),
    );
  }

  @override
  Future<void> dispose() async {
    await _remoteDataSource.dispose();
  }

  // Helper methods

  SubscriptionTier _getTierFromProductId(String productId) {
    for (final tier in SubscriptionTier.values) {
      if (tier.productId == productId) {
        return tier;
      }
    }
    return SubscriptionTier.free;
  }

  SubscriptionTier _getStoredSubscriptionTier() {
    final tierName = _prefs.getString(_activeSubscriptionKey);
    if (tierName == null) {
      return SubscriptionTier.free;
    }

    return SubscriptionTier.values.firstWhere(
      (tier) => tier.name == tierName,
      orElse: () => SubscriptionTier.free,
    );
  }

  String? _getStoredExpiryDate() {
    return _prefs.getString(_subscriptionExpiryKey);
  }

  Future<void> _storeSubscriptionInfo(SubscriptionTier tier) async {
    await _prefs.setString(_activeSubscriptionKey, tier.name);
    
    // Calculate expiry date based on tier
    final now = DateTime.now();
    final expiry = tier == SubscriptionTier.premiumYearly
        ? now.add(const Duration(days: 365))
        : now.add(const Duration(days: 30)); // Monthly or VIP
    
    await _prefs.setString(_subscriptionExpiryKey, expiry.toIso8601String());
  }

  Future<void> _clearSubscriptionInfo() async {
    await _prefs.remove(_activeSubscriptionKey);
    await _prefs.remove(_subscriptionExpiryKey);
  }

  Failure _mapExceptionToFailure(Exception e) {
    return ServerFailure(e.toString());
  }

  // ============================================================
  // CONSUMABLE IAP METHODS
  // ============================================================

  @override
  Future<Either<Failure, List<ConsumableEntity>>> getConsumableProducts() async {
    try {
      final products = await _remoteDataSource.getConsumableProducts();
      return right(products.map((dto) => dto.toEntity()).toList());
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> purchaseConsumable(
    String productId,
  ) async {
    try {
      final purchase = await _remoteDataSource.purchaseConsumable(productId);
      return right(purchase.toEntity());
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, int>> getUserCredits() async {
    try {
      final credits = await _remoteDataSource.getUserCredits();
      return right(credits);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, int>> addCredits(int amount) async {
    try {
      final currentCredits = await _remoteDataSource.getUserCredits();
      final newBalance = currentCredits + amount;
      await _remoteDataSource.saveUserCredits(newBalance);
      return right(newBalance);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, int>> deductCredits(int amount) async {
    try {
      final currentCredits = await _remoteDataSource.getUserCredits();
      if (currentCredits < amount) {
        return left(const ValidationFailure('Insufficient credits'));
      }
      final newBalance = currentCredits - amount;
      await _remoteDataSource.saveUserCredits(newBalance);
      return right(newBalance);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<ConsumableEntity>>> getUserVouchers() async {
    try {
      final vouchers = await _remoteDataSource.getUserVouchers();
      return right(vouchers.map((dto) => dto.toEntity()).toList());
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> addVoucher(ConsumableEntity voucher) async {
    try {
      final dto = ConsumableDto.fromEntity(voucher);
      await _remoteDataSource.saveVoucher(dto);
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> useVoucher(String voucherId) async {
    try {
      await _remoteDataSource.removeVoucher(voucherId);
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  // ============================================================
  // NON-CONSUMABLE IAP METHODS
  // ============================================================

  @override
  Future<Either<Failure, List<NonConsumableEntity>>> getNonConsumableProducts() async {
    try {
      final products = await _remoteDataSource.getNonConsumableProducts();
      return right(products.map((dto) => dto.toEntity()).toList());
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> purchaseNonConsumable(
    String productId,
  ) async {
    try {
      final purchase = await _remoteDataSource.purchaseNonConsumable(productId);
      
      // After successful purchase, unlock the feature
      final featureType = FeatureTypeExtension.fromProductId(productId);
      if (featureType != null) {
        await _remoteDataSource.saveUnlockedFeature(featureType);
      }
      
      return right(purchase.toEntity());
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFeatureUnlocked(
    FeatureType featureType,
  ) async {
    try {
      final isUnlocked = await _remoteDataSource.isFeatureUnlocked(featureType);
      return right(isUnlocked);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<FeatureType>>> getUnlockedFeatures() async {
    try {
      final features = await _remoteDataSource.getUnlockedFeatures();
      return right(features);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> unlockFeature(FeatureType featureType) async {
    try {
      await _remoteDataSource.saveUnlockedFeature(featureType);
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
