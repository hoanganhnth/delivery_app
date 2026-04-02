import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_remote_datasource.dart';
import 'package:delivery_app/features/iap/data/dtos/purchase_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Implementation of IapRepository
/// Uses IapRemoteDataSource for Store API and Backend API operations
/// NO local caching - all data comes from trusted sources (Store/Backend)
class IapRepositoryImpl implements IapRepository {
  final IapRemoteDataSource _remoteDataSource;
  
  StreamSubscription<List<PurchaseDto>>? _purchaseSubscription;

  IapRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, bool>> initialize() async {
    try {
      final result = await _remoteDataSource.initialize();
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
      final activeSubscription = await _remoteDataSource.getActiveSubscription();
      final activeTier = activeSubscription?.tier ?? SubscriptionTier.free;
      
      final subscriptions = products.map((productDto) {
        final product = productDto.toEntity();
        final tier = _getTierFromProductId(product.id);
        final isActive = activeTier == tier && tier != SubscriptionTier.free;
        
        return SubscriptionEntity(
          product: product,
          isActive: isActive,
          expiryDate: isActive ? activeSubscription?.expiryDate : null,
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
      final activeSubscription = await _remoteDataSource.getActiveSubscription();
      return right(activeSubscription != null && activeSubscription.isActive);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, SubscriptionEntity?>> getActiveSubscription() async {
    try {
      final subscription = await _remoteDataSource.getActiveSubscription();
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
    return right(null);
  }

  @override
  Future<Either<Failure, void>> useVoucher(String voucherId) async {
    return right(null);
  }

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
      final isUnlocked = await _remoteDataSource.isFeatureUnlocked(featureType.name);
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
      final featureNames = await _remoteDataSource.getUnlockedFeatures();
      final features = featureNames
          .map((name) => FeatureTypeExtension.fromString(name))
          .whereType<FeatureType>()
          .toList();
      return right(features);
    } on Exception catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> unlockFeature(FeatureType featureType) async {
    return right(null);
  }

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
      final verified = await _remoteDataSource.verifyPurchase(purchase);
      if (verified && purchase.status == 'purchased') {
        await _remoteDataSource.completePurchase(purchase);
      }
    }
  }

  Failure _mapExceptionToFailure(Exception e) {
    return ServerFailure(e.toString());
  }
}
