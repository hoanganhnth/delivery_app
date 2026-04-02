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
import 'package:shared_preferences/shared_preferences.dart';

part 'iap_providers.g.dart';

/// Provider for InAppPurchase instance
@riverpod
InAppPurchase inAppPurchase(Ref ref) {
  return InAppPurchase.instance;
}

/// Provider for SharedPreferences
@riverpod
Future<SharedPreferences> iapSharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider for IAP remote data source
@riverpod
Future<IapRemoteDataSource> iapRemoteDataSource(Ref ref) async {
  final inAppPurchase = ref.watch(inAppPurchaseProvider);
  final prefs = await ref.watch(iapSharedPreferencesProvider.future);
  return IapRemoteDataSourceImpl(inAppPurchase, prefs);
}

/// Provider for IAP repository
@riverpod
Future<IapRepository> iapRepository(Ref ref) async {
  final remoteDataSource = await ref.watch(iapRemoteDataSourceProvider.future);
  final prefs = await ref.watch(iapSharedPreferencesProvider.future);
  
  final repository = IapRepositoryImpl(remoteDataSource, prefs);
  
  // Initialize IAP on repository creation
  await repository.initialize();
  
  return repository;
}

// ============================================================
// SUBSCRIPTION USE CASES
// ============================================================

/// Provider for GetSubscriptionTiersUseCase
@riverpod
Future<GetSubscriptionTiersUseCase> getSubscriptionTiersUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetSubscriptionTiersUseCase(repository);
}

/// Provider for GetActiveSubscriptionUseCase
@riverpod
Future<GetActiveSubscriptionUseCase> getActiveSubscriptionUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetActiveSubscriptionUseCase(repository);
}

/// Provider for PurchaseSubscriptionUseCase
@riverpod
Future<PurchaseSubscriptionUseCase> purchaseSubscriptionUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return PurchaseSubscriptionUseCase(repository);
}

/// Provider for RestorePurchasesUseCase
@riverpod
Future<RestorePurchasesUseCase> restorePurchasesUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return RestorePurchasesUseCase(repository);
}

// ============================================================
// CONSUMABLE USE CASES
// ============================================================

/// Provider for GetConsumableProductsUseCase
@riverpod
Future<GetConsumableProductsUseCase> getConsumableProductsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetConsumableProductsUseCase(repository);
}

/// Provider for PurchaseConsumableUseCase
@riverpod
Future<PurchaseConsumableUseCase> purchaseConsumableUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return PurchaseConsumableUseCase(repository);
}

/// Provider for GetUserCreditsUseCase
@riverpod
Future<GetUserCreditsUseCase> getUserCreditsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetUserCreditsUseCase(repository);
}

/// Provider for AddCreditsUseCase
@riverpod
Future<AddCreditsUseCase> addCreditsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return AddCreditsUseCase(repository);
}

/// Provider for DeductCreditsUseCase
@riverpod
Future<DeductCreditsUseCase> deductCreditsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return DeductCreditsUseCase(repository);
}

// ============================================================
// NON-CONSUMABLE USE CASES
// ============================================================

/// Provider for GetNonConsumableProductsUseCase
@riverpod
Future<GetNonConsumableProductsUseCase> getNonConsumableProductsUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetNonConsumableProductsUseCase(repository);
}

/// Provider for PurchaseNonConsumableUseCase
@riverpod
Future<PurchaseNonConsumableUseCase> purchaseNonConsumableUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return PurchaseNonConsumableUseCase(repository);
}

/// Provider for GetUnlockedFeaturesUseCase
@riverpod
Future<GetUnlockedFeaturesUseCase> getUnlockedFeaturesUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return GetUnlockedFeaturesUseCase(repository);
}

/// Provider for CheckFeatureUnlockedUseCase
@riverpod
Future<CheckFeatureUnlockedUseCase> checkFeatureUnlockedUseCase(Ref ref) async {
  final repository = await ref.watch(iapRepositoryProvider.future);
  return CheckFeatureUnlockedUseCase(repository);
}
