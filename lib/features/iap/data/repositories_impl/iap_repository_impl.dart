import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_local_datasource.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_remote_datasource.dart';
import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/purchase_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Implementation of IapRepository
/// Uses:
/// - IapRemoteDataSource for Store API and Backend API operations
/// - IapLocalDataSource for caching and offline access
class IapRepositoryImpl implements IapRepository {
  final IapRemoteDataSource _remoteDataSource;
  final IapLocalDataSource _localDataSource;
  
  // Stream subscription for purchase updates
  StreamSubscription<List<PurchaseDto>>? _purchaseSubscription;

  IapRepositoryImpl(this._remoteDataSource, this._localDataSource);

  // ============================================================
  // INITIALIZATION
  // ============================================================

  @override
  Future<Either<Failure, bool>> initialize() async {
    try {
      final result = await _remoteDataSource.initialize();
      
      // Listen to purchase stream for verification
      _purchaseSubscription = _remoteDataSource.purchaseStream.listen(
        _handlePurchaseUpdates,
      );
      
      return right(result);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  // ============================================================
  // PRODUCT OPERATIONS
  // ============================================================

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

  // ============================================================
  // SUBSCRIPTION OPERATIONS
  // ============================================================

  @override
  Future<Either<Failure, List<SubscriptionEntity>>> getSubscriptionTiers() async {
    try {
      final products = await _remoteDataSource.getSubscriptionProducts();
      
      // Get cached active tier for comparison
      final cachedActiveTier = _localDataSource.getCachedSubscriptionTier();
      
      final subscriptions = products.map((productDto) {
        final product = productDto.toEntity();
        final tier = _getTierFromProductId(product.id);
        final isActive = cachedActiveTier == tier && tier != SubscriptionTier.free;
        
        return SubscriptionEntity(
          product: product,
          isActive: isActive,
          expiryDate: isActive ? _localDataSource.getCachedSubscriptionExpiry() : null,
          isAutoRenewing: true,
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
  Future<Either<Failure, void>> purchaseSubscription(SubscriptionTier tier) async {
    try {
      // Initiate purchase - result will come via stream
      await _remoteDataSource.purchaseSubscription(tier);
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> restorePurchases() async {
    try {
      await _remoteDataSource.restorePurchases();
      // Restored purchases will come via stream
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> completePurchase(PurchaseEntity purchase) async {
    try {
      final dto = PurchaseDto(
        purchaseId: purchase.purchaseId,
        productId: purchase.productId,
        transactionDate: purchase.transactionDate,
        status: purchase.status.name,
        verificationData: purchase.verificationData,
        pendingCompletePurchase: true,
      );
      await _remoteDataSource.completePurchase(dto);
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
      // First try to get from remote
      final activeSubscription = await _remoteDataSource.getActiveSubscription();
      
      if (activeSubscription != null && activeSubscription.isActive) {
        // Cache locally
        await _localDataSource.saveSubscriptionTier(activeSubscription.tier);
        if (activeSubscription.expiryDate != null) {
          await _localDataSource.saveSubscriptionExpiry(activeSubscription.expiryDate!);
        }
        return right(true);
      }
      
      // Fallback to local cache check
      final cachedTier = _localDataSource.getCachedSubscriptionTier();
      if (cachedTier == SubscriptionTier.free) {
        return right(false);
      }

      final expiryDate = _localDataSource.getCachedSubscriptionExpiry();
      if (expiryDate == null) {
        return right(false);
      }

      final expiry = DateTime.tryParse(expiryDate);
      if (expiry == null || expiry.isBefore(DateTime.now())) {
        await _localDataSource.clearSubscriptionCache();
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
      // Get from backend API
      final subscription = await _remoteDataSource.getActiveSubscription();
      
      if (subscription != null) {
        // Cache locally
        await _localDataSource.saveSubscriptionTier(subscription.tier);
        if (subscription.expiryDate != null) {
          await _localDataSource.saveSubscriptionExpiry(subscription.expiryDate!);
        }
      }
      
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
    await _purchaseSubscription?.cancel();
    await _remoteDataSource.dispose();
  }

  // ============================================================
  // CONSUMABLE OPERATIONS
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
  Future<Either<Failure, void>> purchaseConsumable(String productId) async {
    try {
      await _remoteDataSource.purchaseConsumable(productId);
      // Result will come via stream
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, int>> getUserCredits() async {
    try {
      // Try remote first
      try {
        final credits = await _remoteDataSource.getUserCredits();
        // Cache locally
        await _localDataSource.saveUserCredits(credits);
        return right(credits);
      } catch (_) {
        // Fallback to local cache
        final cachedCredits = _localDataSource.getCachedUserCredits();
        return right(cachedCredits);
      }
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, int>> addCredits(int amount) async {
    try {
      final currentCredits = _localDataSource.getCachedUserCredits();
      final newBalance = currentCredits + amount;
      
      // Save to local cache
      await _localDataSource.saveUserCredits(newBalance);
      
      // TODO: Sync with backend via API
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
      final currentCredits = _localDataSource.getCachedUserCredits();
      
      if (currentCredits < amount) {
        return left(const ValidationFailure('Insufficient credits'));
      }
      
      final newBalance = currentCredits - amount;
      await _localDataSource.saveUserCredits(newBalance);
      
      // TODO: Sync with backend via API
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
      // Try remote first
      try {
        final vouchers = await _remoteDataSource.getUserVouchers();
        // Cache locally
        for (final voucher in vouchers) {
          await _localDataSource.saveVoucher(voucher);
        }
        return right(vouchers.map((dto) => dto.toEntity()).toList());
      } catch (_) {
        // Fallback to local cache
        final cachedVouchers = _localDataSource.getCachedUserVouchers();
        return right(cachedVouchers.map((dto) => dto.toEntity()).toList());
      }
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
      await _localDataSource.saveVoucher(dto);
      // TODO: Sync with backend via API
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
      await _localDataSource.removeVoucher(voucherId);
      // TODO: Sync with backend via API
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  // ============================================================
  // NON-CONSUMABLE OPERATIONS
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
  Future<Either<Failure, void>> purchaseNonConsumable(String productId) async {
    try {
      await _remoteDataSource.purchaseNonConsumable(productId);
      // Result will come via stream
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFeatureUnlocked(FeatureType featureType) async {
    try {
      // Try remote first
      try {
        final isUnlocked = await _remoteDataSource.isFeatureUnlocked(featureType.name);
        if (isUnlocked) {
          // Cache locally
          await _localDataSource.saveUnlockedFeature(featureType.name);
        }
        return right(isUnlocked);
      } catch (_) {
        // Fallback to local cache
        final cachedUnlocked = _localDataSource.isFeatureUnlockedInCache(featureType.name);
        return right(cachedUnlocked);
      }
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<FeatureType>>> getUnlockedFeatures() async {
    try {
      // Try remote first
      try {
        final featureNames = await _remoteDataSource.getUnlockedFeatures();
        // Cache locally
        for (final name in featureNames) {
          await _localDataSource.saveUnlockedFeature(name);
        }
        // Convert to FeatureType
        final features = featureNames
            .map((name) => FeatureTypeExtension.fromString(name))
            .whereType<FeatureType>()
            .toList();
        return right(features);
      } catch (_) {
        // Fallback to local cache
        final cachedFeatureNames = _localDataSource.getCachedUnlockedFeatures();
        final features = cachedFeatureNames
            .map((name) => FeatureTypeExtension.fromString(name))
            .whereType<FeatureType>()
            .toList();
        return right(features);
      }
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> unlockFeature(FeatureType featureType) async {
    try {
      await _localDataSource.saveUnlockedFeature(featureType.name);
      // TODO: Sync with backend via API
      return right(null);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  // ============================================================
  // PRIVATE HELPER METHODS
  // ============================================================

  SubscriptionTier _getTierFromProductId(String productId) {
    for (final tier in SubscriptionTier.values) {
      if (tier.productId == productId) {
        return tier;
      }
    }
    return SubscriptionTier.free;
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDto> purchases) async {
    for (final purchase in purchases) {
      // Verify purchase with backend
      final verified = await _remoteDataSource.verifyPurchase(purchase);
      
      if (verified && purchase.status == 'purchased') {
        // Determine purchase type and handle accordingly
        final tier = _getTierFromProductId(purchase.productId);
        
        if (tier != SubscriptionTier.free) {
          // It's a subscription
          await _localDataSource.saveSubscriptionTier(tier);
          
          // Calculate expiry (simplified - backend should provide this)
          final now = DateTime.now();
          final expiry = tier == SubscriptionTier.premiumYearly
              ? now.add(const Duration(days: 365))
              : now.add(const Duration(days: 30));
          await _localDataSource.saveSubscriptionExpiry(expiry.toIso8601String());
        }
        
        // Complete the purchase
        await _remoteDataSource.completePurchase(purchase);
      }
    }
  }

  Failure _mapExceptionToFailure(Exception e) {
    return ServerFailure(e.toString());
  }
}
