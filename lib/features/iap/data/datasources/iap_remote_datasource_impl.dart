import 'dart:async';
import 'dart:convert';

import 'package:delivery_app/core/logger/app_logger.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_remote_datasource.dart';
import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/iap_product_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/non_consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/purchase_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Storage keys for local IAP data
class _IapStorageKeys {
  static const String userCredits = 'iap_user_credits';
  static const String userVouchers = 'iap_user_vouchers';
  static const String unlockedFeatures = 'iap_unlocked_features';
}

class IapRemoteDataSourceImpl implements IapRemoteDataSource {
  final InAppPurchase _inAppPurchase;
  final SharedPreferences _sharedPreferences;
  StreamSubscription<List<PurchaseDetails>>? _purchaseUpdatedSubscription;
  final StreamController<List<PurchaseDto>> _purchaseStreamController =
      StreamController<List<PurchaseDto>>.broadcast();

  IapRemoteDataSourceImpl(this._inAppPurchase, this._sharedPreferences);

  @override
  Future<bool> initialize() async {
    try {
      AppLogger.d('Initializing IAP connection');
      
      final available = await _inAppPurchase.isAvailable();
      
      if (!available) {
        AppLogger.w('IAP not available on this device');
        return false;
      }

      // Listen to purchase updates
      _purchaseUpdatedSubscription = _inAppPurchase.purchaseStream.listen(
        (List<PurchaseDetails> purchaseDetailsList) {
          AppLogger.d('Purchase update received: ${purchaseDetailsList.length} purchases');
          _handlePurchaseUpdates(purchaseDetailsList);
        },
        onDone: () {
          AppLogger.i('Purchase stream done');
          _purchaseUpdatedSubscription?.cancel();
        },
        onError: (error) {
          AppLogger.e('Purchase stream error', error);
        },
      );

      AppLogger.i('Successfully initialized IAP');
      return true;
    } catch (e) {
      AppLogger.e('Failed to initialize IAP', e);
      throw Exception('Failed to initialize IAP: ${e.toString()}');
    }
  }

  @override
  Future<List<IapProductDto>> getProducts(List<String> productIds) async {
    try {
      AppLogger.d('Getting products: $productIds');
      
      final response = await _inAppPurchase.queryProductDetails(
        productIds.toSet(),
      );

      if (response.error != null) {
        AppLogger.e('Error querying products', response.error);
        throw Exception('Failed to query products: ${response.error?.message}');
      }

      final products = response.productDetails
          .map((product) => IapProductDto.fromProductDetails(product))
          .toList();

      AppLogger.i('Successfully retrieved ${products.length} products');
      return products;
    } catch (e) {
      AppLogger.e('Failed to get products', e);
      throw Exception('Failed to get products: ${e.toString()}');
    }
  }

  @override
  Future<List<IapProductDto>> getSubscriptionProducts() async {
    // Get all subscription tier product IDs
    final subscriptionIds = [
      SubscriptionTier.premiumMonthly.productId,
      SubscriptionTier.premiumYearly.productId,
      SubscriptionTier.vip.productId,
    ];

    return await getProducts(subscriptionIds);
  }

  @override
  Future<PurchaseDto> purchaseSubscription(SubscriptionTier tier) async {
    try {
      AppLogger.d('Purchasing subscription: ${tier.displayName}');
      
      final productId = tier.productId;
      
      // Query product details
      final productDetails = await _getProductDetails(productId);
      
      if (productDetails == null) {
        throw Exception('Subscription product not found: $productId');
      }

      // Create purchase param
      final purchaseParam = PurchaseParam(productDetails: productDetails);
      
      // Buy subscription
      final success = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      if (!success) {
        throw Exception('Failed to initiate subscription purchase');
      }

      AppLogger.i('Subscription purchase initiated: ${tier.displayName}');
      
      // Return a pending purchase
      return PurchaseDto(
        purchaseId: '',
        productId: productId,
        transactionDate: DateTime.now().toIso8601String(),
        status: 'pending',
        pendingCompletePurchase: true,
      );
    } catch (e) {
      AppLogger.e('Failed to purchase subscription: ${tier.displayName}', e);
      throw Exception('Failed to purchase subscription: ${e.toString()}');
    }
  }

  @override
  Future<List<PurchaseDto>> restorePurchases() async {
    try {
      AppLogger.d('Restoring purchases');
      
      await _inAppPurchase.restorePurchases();
      
      AppLogger.i('Successfully initiated restore purchases');
      
      // Restored purchases will come via the purchase stream
      return [];
    } catch (e) {
      AppLogger.e('Failed to restore purchases', e);
      throw Exception('Failed to restore purchases: ${e.toString()}');
    }
  }

  @override
  Future<void> completePurchase(PurchaseDto purchase) async {
    try {
      AppLogger.d('Completing purchase: ${purchase.purchaseId}');
      
      // We need the original PurchaseDetails object
      // This should be tracked internally or passed differently
      // For now, we'll skip completion as it requires the original object
      
      AppLogger.i('Purchase completion requested: ${purchase.purchaseId}');
    } catch (e) {
      AppLogger.e('Failed to complete purchase', e);
      throw Exception('Failed to complete purchase: ${e.toString()}');
    }
  }

  @override
  Stream<List<PurchaseDto>> get purchaseStream => _purchaseStreamController.stream;

  @override
  Future<void> dispose() async {
    try {
      AppLogger.d('Disposing IAP resources');
      
      await _purchaseUpdatedSubscription?.cancel();
      await _purchaseStreamController.close();
      
      AppLogger.i('Successfully disposed IAP resources');
    } catch (e) {
      AppLogger.e('Error disposing IAP resources', e);
    }
  }

  // Helper methods

  Future<ProductDetails?> _getProductDetails(String productId) async {
    final response = await _inAppPurchase.queryProductDetails({productId});
    
    if (response.productDetails.isEmpty) {
      return null;
    }
    
    return response.productDetails.first;
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    final purchases = purchaseDetailsList
        .map((details) => PurchaseDto.fromPurchaseDetails(details))
        .toList();

    // Emit to stream
    _purchaseStreamController.add(purchases);

    // Complete purchases that need completion
    for (final details in purchaseDetailsList) {
      if (details.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(details);
      }
    }
  }

  // ============================================================
  // CONSUMABLE IAP METHODS
  // ============================================================

  @override
  Future<List<ConsumableDto>> getConsumableProducts() async {
    try {
      AppLogger.d('Getting consumable products');

      final productIds = ConsumableProducts.allProductIds;
      final response = await _inAppPurchase.queryProductDetails(
        productIds.toSet(),
      );

      if (response.error != null) {
        AppLogger.e('Error querying consumable products', response.error);
        throw Exception(
            'Failed to query consumable products: ${response.error?.message}');
      }

      final products = response.productDetails.map((product) {
        final iapProduct = IapProductDto.fromProductDetails(product).toEntity();
        return ConsumableDto.fromIapProduct(iapProduct);
      }).toList();

      AppLogger.i('Successfully retrieved ${products.length} consumable products');
      return products;
    } catch (e) {
      AppLogger.e('Failed to get consumable products', e);
      throw Exception('Failed to get consumable products: ${e.toString()}');
    }
  }

  @override
  Future<PurchaseDto> purchaseConsumable(String productId) async {
    try {
      AppLogger.d('Purchasing consumable: $productId');

      final productDetails = await _getProductDetails(productId);

      if (productDetails == null) {
        throw Exception('Consumable product not found: $productId');
      }

      final purchaseParam = PurchaseParam(productDetails: productDetails);

      // Use buyConsumable for consumable products
      final success = await _inAppPurchase.buyConsumable(
        purchaseParam: purchaseParam,
      );

      if (!success) {
        throw Exception('Failed to initiate consumable purchase');
      }

      AppLogger.i('Consumable purchase initiated: $productId');

      return PurchaseDto(
        purchaseId: '',
        productId: productId,
        transactionDate: DateTime.now().toIso8601String(),
        status: 'pending',
        pendingCompletePurchase: true,
      );
    } catch (e) {
      AppLogger.e('Failed to purchase consumable: $productId', e);
      throw Exception('Failed to purchase consumable: ${e.toString()}');
    }
  }

  @override
  Future<int> getUserCredits() async {
    try {
      AppLogger.d('Getting user credits');
      final credits = _sharedPreferences.getInt(_IapStorageKeys.userCredits) ?? 0;
      AppLogger.i('User credits balance: $credits');
      return credits;
    } catch (e) {
      AppLogger.e('Failed to get user credits', e);
      return 0;
    }
  }

  @override
  Future<void> saveUserCredits(int balance) async {
    try {
      AppLogger.d('Saving user credits: $balance');
      await _sharedPreferences.setInt(_IapStorageKeys.userCredits, balance);
      AppLogger.i('Successfully saved user credits: $balance');
    } catch (e) {
      AppLogger.e('Failed to save user credits', e);
      throw Exception('Failed to save user credits: ${e.toString()}');
    }
  }

  @override
  Future<List<ConsumableDto>> getUserVouchers() async {
    try {
      AppLogger.d('Getting user vouchers');
      final vouchersJson =
          _sharedPreferences.getStringList(_IapStorageKeys.userVouchers) ?? [];

      final vouchers = vouchersJson.map((json) {
        final map = jsonDecode(json) as Map<String, dynamic>;
        return ConsumableDto.fromJson(map);
      }).toList();

      AppLogger.i('Retrieved ${vouchers.length} user vouchers');
      return vouchers;
    } catch (e) {
      AppLogger.e('Failed to get user vouchers', e);
      return [];
    }
  }

  @override
  Future<void> saveVoucher(ConsumableDto voucher) async {
    try {
      AppLogger.d('Saving voucher: ${voucher.productId}');
      final currentVouchers =
          _sharedPreferences.getStringList(_IapStorageKeys.userVouchers) ?? [];

      currentVouchers.add(jsonEncode(voucher.toJson()));

      await _sharedPreferences.setStringList(
        _IapStorageKeys.userVouchers,
        currentVouchers,
      );

      AppLogger.i('Successfully saved voucher: ${voucher.productId}');
    } catch (e) {
      AppLogger.e('Failed to save voucher', e);
      throw Exception('Failed to save voucher: ${e.toString()}');
    }
  }

  @override
  Future<void> removeVoucher(String voucherId) async {
    try {
      AppLogger.d('Removing voucher: $voucherId');
      final currentVouchers =
          _sharedPreferences.getStringList(_IapStorageKeys.userVouchers) ?? [];

      final updatedVouchers = currentVouchers.where((json) {
        final map = jsonDecode(json) as Map<String, dynamic>;
        return map['productId'] != voucherId;
      }).toList();

      await _sharedPreferences.setStringList(
        _IapStorageKeys.userVouchers,
        updatedVouchers,
      );

      AppLogger.i('Successfully removed voucher: $voucherId');
    } catch (e) {
      AppLogger.e('Failed to remove voucher', e);
      throw Exception('Failed to remove voucher: ${e.toString()}');
    }
  }

  // ============================================================
  // NON-CONSUMABLE IAP METHODS
  // ============================================================

  @override
  Future<List<NonConsumableDto>> getNonConsumableProducts() async {
    try {
      AppLogger.d('Getting non-consumable products');

      final productIds = NonConsumableProducts.allProductIds;
      final response = await _inAppPurchase.queryProductDetails(
        productIds.toSet(),
      );

      if (response.error != null) {
        AppLogger.e('Error querying non-consumable products', response.error);
        throw Exception(
            'Failed to query non-consumable products: ${response.error?.message}');
      }

      final unlockedFeatures = await getUnlockedFeatures();

      final products = response.productDetails.map((product) {
        final iapProduct = IapProductDto.fromProductDetails(product).toEntity();
        final featureType = FeatureTypeExtension.fromProductId(product.id);
        final isUnlocked =
            featureType != null && unlockedFeatures.contains(featureType);

        return NonConsumableDto.fromIapProduct(
          iapProduct,
          isUnlocked: isUnlocked,
        );
      }).toList();

      AppLogger.i(
          'Successfully retrieved ${products.length} non-consumable products');
      return products;
    } catch (e) {
      AppLogger.e('Failed to get non-consumable products', e);
      throw Exception('Failed to get non-consumable products: ${e.toString()}');
    }
  }

  @override
  Future<PurchaseDto> purchaseNonConsumable(String productId) async {
    try {
      AppLogger.d('Purchasing non-consumable: $productId');

      final productDetails = await _getProductDetails(productId);

      if (productDetails == null) {
        throw Exception('Non-consumable product not found: $productId');
      }

      final purchaseParam = PurchaseParam(productDetails: productDetails);

      // Use buyNonConsumable for non-consumable products
      final success = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      if (!success) {
        throw Exception('Failed to initiate non-consumable purchase');
      }

      AppLogger.i('Non-consumable purchase initiated: $productId');

      return PurchaseDto(
        purchaseId: '',
        productId: productId,
        transactionDate: DateTime.now().toIso8601String(),
        status: 'pending',
        pendingCompletePurchase: true,
      );
    } catch (e) {
      AppLogger.e('Failed to purchase non-consumable: $productId', e);
      throw Exception('Failed to purchase non-consumable: ${e.toString()}');
    }
  }

  @override
  Future<List<FeatureType>> getUnlockedFeatures() async {
    try {
      AppLogger.d('Getting unlocked features');
      final featureNames =
          _sharedPreferences.getStringList(_IapStorageKeys.unlockedFeatures) ??
              [];

      final features = featureNames
          .map((name) {
            try {
              return FeatureType.values.firstWhere((f) => f.name == name);
            } catch (_) {
              return null;
            }
          })
          .whereType<FeatureType>()
          .toList();

      AppLogger.i('Retrieved ${features.length} unlocked features');
      return features;
    } catch (e) {
      AppLogger.e('Failed to get unlocked features', e);
      return [];
    }
  }

  @override
  Future<void> saveUnlockedFeature(FeatureType featureType) async {
    try {
      AppLogger.d('Saving unlocked feature: ${featureType.name}');
      final currentFeatures =
          _sharedPreferences.getStringList(_IapStorageKeys.unlockedFeatures) ??
              [];

      if (!currentFeatures.contains(featureType.name)) {
        currentFeatures.add(featureType.name);
        await _sharedPreferences.setStringList(
          _IapStorageKeys.unlockedFeatures,
          currentFeatures,
        );
      }

      AppLogger.i('Successfully saved unlocked feature: ${featureType.name}');
    } catch (e) {
      AppLogger.e('Failed to save unlocked feature', e);
      throw Exception('Failed to save unlocked feature: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFeatureUnlocked(FeatureType featureType) async {
    try {
      AppLogger.d('Checking if feature is unlocked: ${featureType.name}');
      final features = await getUnlockedFeatures();
      final isUnlocked = features.contains(featureType);
      AppLogger.i('Feature ${featureType.name} is unlocked: $isUnlocked');
      return isUnlocked;
    } catch (e) {
      AppLogger.e('Failed to check feature unlock status', e);
      return false;
    }
  }
}
