import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/iap_product_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/non_consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/purchase_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'iap_api_service.g.dart';

/// API service for IAP backend operations
@RestApi()
abstract class IapApiService {
  factory IapApiService(Dio dio) = _IapApiService;

  // ============================================================
  // SUBSCRIPTION APIs
  // ============================================================

  /// Get available subscription tiers from backend
  @GET('/iap/subscriptions/tiers')
  Future<BaseResponseDto<List<IapProductDto>>> getSubscriptionTiers();

  /// Get user's active subscription
  @GET('/iap/subscriptions/active')
  Future<BaseResponseDto<IapProductDto?>> getActiveSubscription();

  /// Verify and activate subscription purchase
  @POST('/iap/subscriptions/verify')
  Future<BaseResponseDto<PurchaseDto>> verifySubscriptionPurchase(
    @Body() Map<String, dynamic> purchaseData,
  );

  /// Restore subscription purchases
  @POST('/iap/subscriptions/restore')
  Future<BaseResponseDto<List<PurchaseDto>>> restoreSubscriptionPurchases(
    @Body() Map<String, dynamic> restoreData,
  );

  // ============================================================
  // CONSUMABLE APIs
  // ============================================================

  /// Get available consumable products
  @GET('/iap/consumables/products')
  Future<BaseResponseDto<List<ConsumableDto>>> getConsumableProducts();

  /// Verify consumable purchase and add to user balance
  @POST('/iap/consumables/verify')
  Future<BaseResponseDto<PurchaseDto>> verifyConsumablePurchase(
    @Body() Map<String, dynamic> purchaseData,
  );

  /// Get user's credit balance
  @GET('/iap/consumables/credits')
  Future<BaseResponseDto<int>> getUserCredits();

  /// Add credits to user balance
  @POST('/iap/consumables/credits/add')
  Future<BaseResponseDto<int>> addCredits(
    @Body() Map<String, dynamic> data,
  );

  /// Deduct credits from user balance
  @POST('/iap/consumables/credits/deduct')
  Future<BaseResponseDto<int>> deductCredits(
    @Body() Map<String, dynamic> data,
  );

  /// Get user's voucher inventory
  @GET('/iap/consumables/vouchers')
  Future<BaseResponseDto<List<ConsumableDto>>> getUserVouchers();

  /// Add voucher to user inventory
  @POST('/iap/consumables/vouchers/add')
  Future<BaseResponseDto<void>> addVoucher(
    @Body() ConsumableDto voucher,
  );

  /// Use/consume a voucher
  @POST('/iap/consumables/vouchers/use')
  Future<BaseResponseDto<void>> useVoucher(
    @Body() Map<String, dynamic> data,
  );

  // ============================================================
  // NON-CONSUMABLE APIs
  // ============================================================

  /// Get available non-consumable products (features)
  @GET('/iap/non-consumables/products')
  Future<BaseResponseDto<List<NonConsumableDto>>> getNonConsumableProducts();

  /// Verify non-consumable purchase and unlock feature
  @POST('/iap/non-consumables/verify')
  Future<BaseResponseDto<PurchaseDto>> verifyNonConsumablePurchase(
    @Body() Map<String, dynamic> purchaseData,
  );

  /// Get user's unlocked features
  @GET('/iap/non-consumables/unlocked')
  Future<BaseResponseDto<List<String>>> getUnlockedFeatures();

  /// Check if a specific feature is unlocked
  @GET('/iap/non-consumables/check/{featureType}')
  Future<BaseResponseDto<bool>> isFeatureUnlocked(
    @Path('featureType') String featureType,
  );

  /// Unlock a feature (after verified purchase)
  @POST('/iap/non-consumables/unlock')
  Future<BaseResponseDto<void>> unlockFeature(
    @Body() Map<String, dynamic> data,
  );

  // ============================================================
  // GENERAL APIs
  // ============================================================

  /// Complete a purchase on backend
  @POST('/iap/purchases/complete')
  Future<BaseResponseDto<void>> completePurchase(
    @Body() PurchaseDto purchase,
  );

  /// Restore all purchases (subscriptions + non-consumables)
  @POST('/iap/purchases/restore')
  Future<BaseResponseDto<List<PurchaseDto>>> restorePurchases(
    @Body() Map<String, dynamic> restoreData,
  );
}
