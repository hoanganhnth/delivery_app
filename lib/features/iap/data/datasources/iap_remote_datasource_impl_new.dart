import 'dart:async';

import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/core/logger/app_logger.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_api_service.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_remote_datasource.dart';
import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/iap_product_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/non_consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/purchase_dto.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:dio/dio.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

/// Implementation of IapRemoteDataSource
/// Handles:
/// - App Store / Google Play via in_app_purchase plugin
/// - Backend API via IapApiService
/// 
/// Note: Does NOT handle local storage - use IapLocalDataSource for caching
class IapRemoteDataSourceImpl implements IapRemoteDataSource {
  final InAppPurchase _inAppPurchase;
  final IapApiService _apiService;
  
  StreamSubscription<List<PurchaseDetails>>? _purchaseUpdatedSubscription;
  final StreamController<List<PurchaseDto>> _purchaseStreamController =
      StreamController<List<PurchaseDto>>.broadcast();
  
  // Track pending purchases for completion
  final Map<String, PurchaseDetails> _pendingPurchases = {};

  IapRemoteDataSourceImpl(
    this._inAppPurchase,
    this._apiService,
  );

  // ============================================================
  // INITIALIZATION & GENERAL
  // ============================================================

  @override
  Future<bool> initialize() async {
    try {
      AppLogger.d('Initializing IAP connection');
      
      final available = await _inAppPurchase.isAvailable();
      
      if (!available) {
        AppLogger.w('IAP not available on this device');
        return false;
      }

      // Listen to purchase updates from store
      _purchaseUpdatedSubscription = _inAppPurchase.purchaseStream.listen(
        _handlePurchaseUpdates,
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
  Future<bool> isAvailable() async {
    try {
      return await _inAppPurchase.isAvailable();
    } catch (e) {
      AppLogger.e('Failed to check IAP availability', e);
      return false;
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
  Stream<List<PurchaseDto>> get purchaseStream => _purchaseStreamController.stream;

  @override
  Future<void> dispose() async {
    try {
      AppLogger.d('Disposing IAP resources');
      
      await _purchaseUpdatedSubscription?.cancel();
      await _purchaseStreamController.close();
      _pendingPurchases.clear();
      
      AppLogger.i('Successfully disposed IAP resources');
    } catch (e) {
      AppLogger.e('Error disposing IAP resources', e);
    }
  }

  // ============================================================
  // PURCHASE OPERATIONS
  // ============================================================

  @override
  Future<void> buyProduct(String productId) async {
    try {
      AppLogger.d('Buying product: $productId');
      
      final productDetails = await _getProductDetails(productId);
      
      if (productDetails == null) {
        throw Exception('Product not found: $productId');
      }

      final purchaseParam = PurchaseParam(productDetails: productDetails);
      
      // Determine if consumable or non-consumable
      // For simplicity, use buyNonConsumable - actual type handled in verify
      final success = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      if (!success) {
        throw Exception('Failed to initiate purchase');
      }

      AppLogger.i('Purchase initiated: $productId');
      // Result will be delivered via purchaseStream
    } catch (e) {
      AppLogger.e('Failed to buy product: $productId', e);
      throw Exception('Failed to buy product: ${e.toString()}');
    }
  }

  @override
  Future<void> restorePurchases() async {
    try {
      AppLogger.d('Restoring purchases');
      
      await _inAppPurchase.restorePurchases();
      
      AppLogger.i('Restore purchases initiated');
      // Restored purchases will come via purchaseStream
    } catch (e) {
      AppLogger.e('Failed to restore purchases', e);
      throw Exception('Failed to restore purchases: ${e.toString()}');
    }
  }

  @override
  Future<void> completePurchase(PurchaseDto purchase) async {
    try {
      AppLogger.d('Completing purchase: ${purchase.purchaseId}');
      
      // Get the original PurchaseDetails from our tracking map
      final details = _pendingPurchases[purchase.purchaseId];
      
      if (details != null) {
        await _inAppPurchase.completePurchase(details);
        _pendingPurchases.remove(purchase.purchaseId);
        AppLogger.i('Purchase completed: ${purchase.purchaseId}');
      } else {
        AppLogger.w('PurchaseDetails not found for: ${purchase.purchaseId}');
      }
    } catch (e) {
      AppLogger.e('Failed to complete purchase', e);
      throw Exception('Failed to complete purchase: ${e.toString()}');
    }
  }

  @override
  Future<bool> verifyPurchase(PurchaseDto purchase) async {
    try {
      AppLogger.d('Verifying purchase with backend: ${purchase.purchaseId}');
      
      // Determine purchase type and call appropriate verify endpoint
      final purchaseData = {
        'purchaseId': purchase.purchaseId,
        'productId': purchase.productId,
        'transactionDate': purchase.transactionDate,
        'verificationData': purchase.verificationData,
        'status': purchase.status,
      };

      // Try subscription verify first
      try {
        final response = await _apiService.verifySubscriptionPurchase(purchaseData);
        if (response.isSuccess) {
          AppLogger.i('Purchase verified as subscription');
          return true;
        }
      } catch (_) {
        // Not a subscription, try consumable
      }

      // Try consumable verify
      try {
        final response = await _apiService.verifyConsumablePurchase(purchaseData);
        if (response.isSuccess) {
          AppLogger.i('Purchase verified as consumable');
          return true;
        }
      } catch (_) {
        // Not a consumable, try non-consumable
      }

      // Try non-consumable verify
      try {
        final response = await _apiService.verifyNonConsumablePurchase(purchaseData);
        if (response.isSuccess) {
          AppLogger.i('Purchase verified as non-consumable');
          return true;
        }
      } catch (_) {
        // Verification failed
      }

      AppLogger.w('Purchase verification failed: ${purchase.purchaseId}');
      return false;
    } on DioException catch (e) {
      AppLogger.e('Failed to verify purchase', e);
      return false;
    } catch (e) {
      AppLogger.e('Unexpected error verifying purchase', e);
      return false;
    }
  }

  // ============================================================
  // SUBSCRIPTION OPERATIONS
  // ============================================================

  @override
  Future<List<IapProductDto>> getSubscriptionProducts() async {
    final subscriptionIds = [
      SubscriptionTier.premiumMonthly.productId,
      SubscriptionTier.premiumYearly.productId,
      SubscriptionTier.vip.productId,
    ];
    return await getProducts(subscriptionIds);
  }

  @override
  Future<SubscriptionEntity?> getActiveSubscription() async {
    try {
      AppLogger.d('Getting active subscription from backend');
      final response = await _apiService.getActiveSubscription();
      
      if (response.isSuccess && response.data != null) {
        final productDto = response.data!;
        final product = productDto.toEntity();
        final tier = _getTierFromProductId(product.id);
        
        // Create subscription entity with full state
        final subscription = SubscriptionEntity(
          product: product,
          isActive: true,
          expiryDate: null, // Backend should return this in a proper DTO
          isAutoRenewing: true,
          tier: tier,
        );
        
        AppLogger.i('Active subscription found: ${tier.displayName}');
        return subscription;
      } else {
        AppLogger.w('No active subscription found');
        return null;
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get active subscription', e);
      return null;
    } catch (e) {
      AppLogger.e('Unexpected error getting active subscription', e);
      return null;
    }
  }

  @override
  Future<void> purchaseSubscription(SubscriptionTier tier) async {
    try {
      AppLogger.d('Purchasing subscription: ${tier.displayName}');
      
      final productId = tier.productId;
      final productDetails = await _getProductDetails(productId);
      
      if (productDetails == null) {
        throw Exception('Subscription product not found: $productId');
      }

      final purchaseParam = PurchaseParam(productDetails: productDetails);
      
      final success = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      if (!success) {
        throw Exception('Failed to initiate subscription purchase');
      }

      AppLogger.i('Subscription purchase initiated: ${tier.displayName}');
      // Result will be delivered via purchaseStream
    } catch (e) {
      AppLogger.e('Failed to purchase subscription: ${tier.displayName}', e);
      throw Exception('Failed to purchase subscription: ${e.toString()}');
    }
  }

  // ============================================================
  // CONSUMABLE OPERATIONS
  // ============================================================

  @override
  Future<List<ConsumableDto>> getConsumableProducts() async {
    try {
      AppLogger.d('Getting consumable products from backend');
      
      // First try backend API
      try {
        final response = await _apiService.getConsumableProducts();
        if (response.isSuccess && response.data != null) {
          AppLogger.i('Retrieved ${response.data!.length} consumable products from backend');
          return response.data!;
        }
      } on DioException catch (e) {
        AppLogger.w('Backend API failed, falling back to store: $e');
      }
      
      // Fallback to store query
      final productIds = ConsumableProducts.allProductIds;
      final storeResponse = await _inAppPurchase.queryProductDetails(
        productIds.toSet(),
      );

      if (storeResponse.error != null) {
        throw Exception('Failed to query products: ${storeResponse.error?.message}');
      }

      final products = storeResponse.productDetails.map((product) {
        final iapProduct = IapProductDto.fromProductDetails(product).toEntity();
        return ConsumableDto.fromIapProduct(iapProduct);
      }).toList();

      AppLogger.i('Retrieved ${products.length} consumable products from store');
      return products;
    } catch (e) {
      AppLogger.e('Failed to get consumable products', e);
      throw Exception('Failed to get consumable products: ${e.toString()}');
    }
  }

  @override
  Future<void> purchaseConsumable(String productId) async {
    try {
      AppLogger.d('Purchasing consumable: $productId');

      final productDetails = await _getProductDetails(productId);

      if (productDetails == null) {
        throw Exception('Consumable product not found: $productId');
      }

      final purchaseParam = PurchaseParam(productDetails: productDetails);

      final success = await _inAppPurchase.buyConsumable(
        purchaseParam: purchaseParam,
      );

      if (!success) {
        throw Exception('Failed to initiate consumable purchase');
      }

      AppLogger.i('Consumable purchase initiated: $productId');
      // Result will be delivered via purchaseStream
    } catch (e) {
      AppLogger.e('Failed to purchase consumable: $productId', e);
      throw Exception('Failed to purchase consumable: ${e.toString()}');
    }
  }

  @override
  Future<int> getUserCredits() async {
    try {
      AppLogger.d('Getting user credits from backend');
      final response = await _apiService.getUserCredits();
      
      if (response.isSuccess && response.data != null) {
        AppLogger.i('User credits balance: ${response.data}');
        return response.data!;
      } else {
        AppLogger.w('Failed to get credits from backend');
        return 0;
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get user credits from backend', e);
      throw Exception('Failed to get user credits: ${e.toString()}');
    } catch (e) {
      AppLogger.e('Unexpected error getting user credits', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<ConsumableDto>> getUserVouchers() async {
    try {
      AppLogger.d('Getting user vouchers from backend');
      final response = await _apiService.getUserVouchers();
      
      if (response.isSuccess && response.data != null) {
        AppLogger.i('Retrieved ${response.data!.length} user vouchers');
        return response.data!;
      } else {
        AppLogger.w('Failed to get vouchers from backend');
        return [];
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get user vouchers from backend', e);
      throw Exception('Failed to get user vouchers: ${e.toString()}');
    } catch (e) {
      AppLogger.e('Unexpected error getting user vouchers', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  // ============================================================
  // NON-CONSUMABLE OPERATIONS
  // ============================================================

  @override
  Future<List<NonConsumableDto>> getNonConsumableProducts() async {
    try {
      AppLogger.d('Getting non-consumable products');
      
      // Try backend first
      try {
        final response = await _apiService.getNonConsumableProducts();
        if (response.isSuccess && response.data != null) {
          AppLogger.i('Retrieved ${response.data!.length} non-consumable products from backend');
          return response.data!;
        }
      } on DioException catch (e) {
        AppLogger.w('Backend API failed, falling back to store: $e');
      }

      // Fallback to store query
      final productIds = NonConsumableProducts.allProductIds;
      final storeResponse = await _inAppPurchase.queryProductDetails(
        productIds.toSet(),
      );

      if (storeResponse.error != null) {
        throw Exception('Failed to query products: ${storeResponse.error?.message}');
      }

      // Get unlocked features to mark products
      final unlockedFeatures = await getUnlockedFeatures();

      final products = storeResponse.productDetails.map((product) {
        final iapProduct = IapProductDto.fromProductDetails(product).toEntity();
        final featureType = FeatureTypeExtension.fromProductId(product.id);
        final isUnlocked = featureType != null && unlockedFeatures.contains(featureType.name);

        return NonConsumableDto.fromIapProduct(
          iapProduct,
          isUnlocked: isUnlocked,
        );
      }).toList();

      AppLogger.i('Retrieved ${products.length} non-consumable products from store');
      return products;
    } catch (e) {
      AppLogger.e('Failed to get non-consumable products', e);
      throw Exception('Failed to get non-consumable products: ${e.toString()}');
    }
  }

  @override
  Future<void> purchaseNonConsumable(String productId) async {
    try {
      AppLogger.d('Purchasing non-consumable: $productId');

      final productDetails = await _getProductDetails(productId);

      if (productDetails == null) {
        throw Exception('Non-consumable product not found: $productId');
      }

      final purchaseParam = PurchaseParam(productDetails: productDetails);

      final success = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      if (!success) {
        throw Exception('Failed to initiate non-consumable purchase');
      }

      AppLogger.i('Non-consumable purchase initiated: $productId');
      // Result will be delivered via purchaseStream
    } catch (e) {
      AppLogger.e('Failed to purchase non-consumable: $productId', e);
      throw Exception('Failed to purchase non-consumable: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getUnlockedFeatures() async {
    try {
      AppLogger.d('Getting unlocked features from backend');
      final response = await _apiService.getUnlockedFeatures();
      
      if (response.isSuccess && response.data != null) {
        AppLogger.i('Retrieved ${response.data!.length} unlocked features');
        return response.data!;
      } else {
        AppLogger.w('Failed to get unlocked features from backend');
        return [];
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get unlocked features from backend', e);
      throw Exception('Failed to get unlocked features: ${e.toString()}');
    } catch (e) {
      AppLogger.e('Unexpected error getting unlocked features', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFeatureUnlocked(String featureId) async {
    try {
      AppLogger.d('Checking if feature is unlocked: $featureId');
      final response = await _apiService.isFeatureUnlocked(featureId);
      
      if (response.isSuccess && response.data != null) {
        AppLogger.i('Feature $featureId unlocked: ${response.data}');
        return response.data!;
      } else {
        AppLogger.w('Failed to check feature unlock status');
        return false;
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to check feature unlock status', e);
      return false;
    } catch (e) {
      AppLogger.e('Unexpected error checking feature unlock status', e);
      return false;
    }
  }

  // ============================================================
  // PRIVATE HELPER METHODS
  // ============================================================

  Future<ProductDetails?> _getProductDetails(String productId) async {
    final response = await _inAppPurchase.queryProductDetails({productId});
    
    if (response.productDetails.isEmpty) {
      return null;
    }
    
    return response.productDetails.first;
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    AppLogger.d('Purchase update received: ${purchaseDetailsList.length} purchases');
    
    final purchases = <PurchaseDto>[];
    
    for (final details in purchaseDetailsList) {
      // Track pending purchases for later completion
      final purchaseId = details.purchaseID;
      if (details.pendingCompletePurchase && purchaseId != null) {
        _pendingPurchases[purchaseId] = details;
      }
      
      purchases.add(PurchaseDto.fromPurchaseDetails(details));
    }

    // Emit to stream
    _purchaseStreamController.add(purchases);
  }

  SubscriptionTier _getTierFromProductId(String productId) {
    for (final tier in SubscriptionTier.values) {
      if (tier.productId == productId) {
        return tier;
      }
    }
    return SubscriptionTier.free;
  }
}
