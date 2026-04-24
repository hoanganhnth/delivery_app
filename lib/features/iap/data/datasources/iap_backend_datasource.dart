import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import 'package:delivery_app/core/error/dio_exception_handler.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_api_service.dart';
import 'package:delivery_app/features/iap/data/dtos/consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/iap_product_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/non_consumable_dto.dart';
import 'package:delivery_app/features/iap/data/dtos/purchase_dto.dart';
import 'package:dio/dio.dart';

/// Backend API datasource for IAP operations
abstract class IapBackendDataSource {
  // Subscription
  Future<BaseResponseDto<List<IapProductDto>>> getSubscriptionTiers();
  Future<BaseResponseDto<IapProductDto?>> getActiveSubscription();
  Future<BaseResponseDto<PurchaseDto>> verifySubscriptionPurchase(Map<String, dynamic> purchaseData);
  Future<BaseResponseDto<List<PurchaseDto>>> restoreSubscriptionPurchases(Map<String, dynamic> restoreData);

  // Consumable
  Future<BaseResponseDto<List<ConsumableDto>>> getConsumableProducts();
  Future<BaseResponseDto<PurchaseDto>> verifyConsumablePurchase(Map<String, dynamic> purchaseData);
  Future<BaseResponseDto<int>> getUserCredits();
  Future<BaseResponseDto<int>> addCredits(int amount, String purchaseId);
  Future<BaseResponseDto<int>> deductCredits(int amount, String orderId, String reason);
  Future<BaseResponseDto<List<ConsumableDto>>> getUserVouchers();
  Future<BaseResponseDto<void>> addVoucher(ConsumableDto voucher);
  Future<BaseResponseDto<void>> useVoucher(String voucherId, String orderId);

  // Non-Consumable
  Future<BaseResponseDto<List<NonConsumableDto>>> getNonConsumableProducts();
  Future<BaseResponseDto<PurchaseDto>> verifyNonConsumablePurchase(Map<String, dynamic> purchaseData);
  Future<BaseResponseDto<List<String>>> getUnlockedFeatures();
  Future<BaseResponseDto<bool>> isFeatureUnlocked(String featureType);
  Future<BaseResponseDto<void>> unlockFeature(String featureType, String purchaseId);

  // General
  Future<BaseResponseDto<void>> completePurchase(PurchaseDto purchase);
  Future<BaseResponseDto<List<PurchaseDto>>> restorePurchases(Map<String, dynamic> restoreData);
}

class IapBackendDataSourceImpl implements IapBackendDataSource {
  final IapApiService _apiService;

  IapBackendDataSourceImpl(this._apiService);

  // ============================================================
  // SUBSCRIPTION METHODS
  // ============================================================

  @override
  Future<BaseResponseDto<List<IapProductDto>>> getSubscriptionTiers() async {
    try {
      AppLogger.d('Getting subscription tiers from backend');
      final response = await _apiService.getSubscriptionTiers();
      AppLogger.i('Successfully retrieved subscription tiers');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get subscription tiers', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting subscription tiers', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<IapProductDto?>> getActiveSubscription() async {
    try {
      AppLogger.d('Getting active subscription from backend');
      final response = await _apiService.getActiveSubscription();
      AppLogger.i('Successfully retrieved active subscription');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get active subscription', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting active subscription', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<PurchaseDto>> verifySubscriptionPurchase(
    Map<String, dynamic> purchaseData,
  ) async {
    try {
      AppLogger.d('Verifying subscription purchase with backend');
      final response = await _apiService.verifySubscriptionPurchase(purchaseData);
      AppLogger.i('Successfully verified subscription purchase');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to verify subscription purchase', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error verifying subscription purchase', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<PurchaseDto>>> restoreSubscriptionPurchases(
    Map<String, dynamic> restoreData,
  ) async {
    try {
      AppLogger.d('Restoring subscription purchases with backend');
      final response = await _apiService.restoreSubscriptionPurchases(restoreData);
      AppLogger.i('Successfully restored subscription purchases');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to restore subscription purchases', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error restoring subscription purchases', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  // ============================================================
  // CONSUMABLE METHODS
  // ============================================================

  @override
  Future<BaseResponseDto<List<ConsumableDto>>> getConsumableProducts() async {
    try {
      AppLogger.d('Getting consumable products from backend');
      final response = await _apiService.getConsumableProducts();
      AppLogger.i('Successfully retrieved consumable products');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get consumable products', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting consumable products', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<PurchaseDto>> verifyConsumablePurchase(
    Map<String, dynamic> purchaseData,
  ) async {
    try {
      AppLogger.d('Verifying consumable purchase with backend');
      final response = await _apiService.verifyConsumablePurchase(purchaseData);
      AppLogger.i('Successfully verified consumable purchase');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to verify consumable purchase', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error verifying consumable purchase', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<int>> getUserCredits() async {
    try {
      AppLogger.d('Getting user credits from backend');
      final response = await _apiService.getUserCredits();
      AppLogger.i('Successfully retrieved user credits');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get user credits', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting user credits', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<int>> addCredits(int amount, String purchaseId) async {
    try {
      AppLogger.d('Adding credits: $amount');
      final response = await _apiService.addCredits({
        'amount': amount,
        'purchaseId': purchaseId,
      });
      AppLogger.i('Successfully added credits');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to add credits', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error adding credits', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<int>> deductCredits(
    int amount,
    String orderId,
    String reason,
  ) async {
    try {
      AppLogger.d('Deducting credits: $amount');
      final response = await _apiService.deductCredits({
        'amount': amount,
        'orderId': orderId,
        'reason': reason,
      });
      AppLogger.i('Successfully deducted credits');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to deduct credits', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error deducting credits', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<ConsumableDto>>> getUserVouchers() async {
    try {
      AppLogger.d('Getting user vouchers from backend');
      final response = await _apiService.getUserVouchers();
      AppLogger.i('Successfully retrieved user vouchers');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get user vouchers', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting user vouchers', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<void>> addVoucher(ConsumableDto voucher) async {
    try {
      AppLogger.d('Adding voucher to user inventory');
      final response = await _apiService.addVoucher(voucher);
      AppLogger.i('Successfully added voucher');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to add voucher', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error adding voucher', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<void>> useVoucher(String voucherId, String orderId) async {
    try {
      AppLogger.d('Using voucher: $voucherId');
      final response = await _apiService.useVoucher({
        'voucherId': voucherId,
        'orderId': orderId,
      });
      AppLogger.i('Successfully used voucher');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to use voucher', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error using voucher', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  // ============================================================
  // NON-CONSUMABLE METHODS
  // ============================================================

  @override
  Future<BaseResponseDto<List<NonConsumableDto>>> getNonConsumableProducts() async {
    try {
      AppLogger.d('Getting non-consumable products from backend');
      final response = await _apiService.getNonConsumableProducts();
      AppLogger.i('Successfully retrieved non-consumable products');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get non-consumable products', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting non-consumable products', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<PurchaseDto>> verifyNonConsumablePurchase(
    Map<String, dynamic> purchaseData,
  ) async {
    try {
      AppLogger.d('Verifying non-consumable purchase with backend');
      final response = await _apiService.verifyNonConsumablePurchase(purchaseData);
      AppLogger.i('Successfully verified non-consumable purchase');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to verify non-consumable purchase', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error verifying non-consumable purchase', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<String>>> getUnlockedFeatures() async {
    try {
      AppLogger.d('Getting unlocked features from backend');
      final response = await _apiService.getUnlockedFeatures();
      AppLogger.i('Successfully retrieved unlocked features');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get unlocked features', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting unlocked features', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<bool>> isFeatureUnlocked(String featureType) async {
    try {
      AppLogger.d('Checking if feature is unlocked: $featureType');
      final response = await _apiService.isFeatureUnlocked(featureType);
      AppLogger.i('Successfully checked feature unlock status');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to check feature unlock status', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error checking feature unlock status', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<void>> unlockFeature(
    String featureType,
    String purchaseId,
  ) async {
    try {
      AppLogger.d('Unlocking feature: $featureType');
      final response = await _apiService.unlockFeature({
        'featureType': featureType,
        'purchaseId': purchaseId,
      });
      AppLogger.i('Successfully unlocked feature');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to unlock feature', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error unlocking feature', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  // ============================================================
  // GENERAL METHODS
  // ============================================================

  @override
  Future<BaseResponseDto<void>> completePurchase(PurchaseDto purchase) async {
    try {
      AppLogger.d('Completing purchase with backend: ${purchase.purchaseId}');
      final response = await _apiService.completePurchase(purchase);
      AppLogger.i('Successfully completed purchase');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to complete purchase', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error completing purchase', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<PurchaseDto>>> restorePurchases(
    Map<String, dynamic> restoreData,
  ) async {
    try {
      AppLogger.d('Restoring all purchases with backend');
      final response = await _apiService.restorePurchases(restoreData);
      AppLogger.i('Successfully restored all purchases');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to restore purchases', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error restoring purchases', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
