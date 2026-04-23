import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_api_service.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_remote_datasource.dart';
import 'package:delivery_app/features/iap/data/datasources/iap_remote_datasource_impl.dart';
import 'package:delivery_app/features/iap/data/repositories_impl/iap_repository_impl.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:delivery_app/features/iap/domain/usecases/add_credits_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/check_feature_unlocked_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/deduct_credits_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_active_subscription_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_consumable_products_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_non_consumable_products_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_subscription_tiers_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_unlocked_features_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_user_credits_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/purchase_consumable_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/purchase_non_consumable_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/purchase_subscription_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/restore_purchases_usecase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'iap_providers.g.dart';

/// Provider for InAppPurchase instance
@Riverpod(keepAlive: true)
InAppPurchase inAppPurchase(Ref ref) {
  return InAppPurchase.instance;
}

/// Provider for IAP API service
@Riverpod(keepAlive: true)
IapApiService iapApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return IapApiService(dio);
}

/// Provider for IAP remote data source
@Riverpod(keepAlive: true)
IapRemoteDataSource iapRemoteDataSource(Ref ref) {
  final inAppPurchase = ref.watch(inAppPurchaseProvider);
  final apiService = ref.watch(iapApiServiceProvider);
  return IapRemoteDataSourceImpl(inAppPurchase, apiService);
}

/// Provider for IAP repository
@Riverpod(keepAlive: true)
Future<IapRepository> iapRepository(Ref ref) async {
  final remoteDataSource = ref.watch(iapRemoteDataSourceProvider);
  
  final repository = IapRepositoryImpl(remoteDataSource);
  
  // Initialize IAP on repository creation
  await repository.initialize();
  
  return repository;
}

// ============================================================
// SUBSCRIPTION USE CASES
// ============================================================

/// Provider for GetSubscriptionTiersUseCase
@Riverpod(keepAlive: true)
Future<GetSubscriptionTiersUseCase> getSubscriptionTiersUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetSubscriptionTiersUseCase(repository);
}

/// Provider for GetActiveSubscriptionUseCase
@Riverpod(keepAlive: true)
Future<GetActiveSubscriptionUseCase> getActiveSubscriptionUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetActiveSubscriptionUseCase(repository);
}

/// Provider for PurchaseSubscriptionUseCase
@Riverpod(keepAlive: true)
Future<PurchaseSubscriptionUseCase> purchaseSubscriptionUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return PurchaseSubscriptionUseCase(repository);
}

/// Provider for RestorePurchasesUseCase
@Riverpod(keepAlive: true)
Future<RestorePurchasesUseCase> restorePurchasesUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return RestorePurchasesUseCase(repository);
}

// ============================================================
// CONSUMABLE USE CASES
// ============================================================

/// Provider for GetConsumableProductsUseCase
@Riverpod(keepAlive: true)
Future<GetConsumableProductsUseCase> getConsumableProductsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetConsumableProductsUseCase(repository);
}

/// Provider for PurchaseConsumableUseCase
@Riverpod(keepAlive: true)
Future<PurchaseConsumableUseCase> purchaseConsumableUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return PurchaseConsumableUseCase(repository);
}

/// Provider for GetUserCreditsUseCase
@Riverpod(keepAlive: true)
Future<GetUserCreditsUseCase> getUserCreditsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetUserCreditsUseCase(repository);
}

/// Provider for AddCreditsUseCase
@Riverpod(keepAlive: true)
Future<AddCreditsUseCase> addCreditsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return AddCreditsUseCase(repository);
}

/// Provider for DeductCreditsUseCase
@Riverpod(keepAlive: true)
Future<DeductCreditsUseCase> deductCreditsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return DeductCreditsUseCase(repository);
}

// ============================================================
// NON-CONSUMABLE USE CASES
// ============================================================

/// Provider for GetNonConsumableProductsUseCase
@Riverpod(keepAlive: true)
Future<GetNonConsumableProductsUseCase> getNonConsumableProductsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetNonConsumableProductsUseCase(repository);
}

/// Provider for PurchaseNonConsumableUseCase
@Riverpod(keepAlive: true)
Future<PurchaseNonConsumableUseCase> purchaseNonConsumableUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return PurchaseNonConsumableUseCase(repository);
}

/// Provider for GetUnlockedFeaturesUseCase
@Riverpod(keepAlive: true)
Future<GetUnlockedFeaturesUseCase> getUnlockedFeaturesUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetUnlockedFeaturesUseCase(repository);
}

/// Provider for CheckFeatureUnlockedUseCase
@Riverpod(keepAlive: true)
Future<CheckFeatureUnlockedUseCase> checkFeatureUnlockedUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return CheckFeatureUnlockedUseCase(repository);
}
