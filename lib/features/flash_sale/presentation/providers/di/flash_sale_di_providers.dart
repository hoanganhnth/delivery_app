import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/datasources/flash_sale_api_service.dart';
import '../../../data/repositories_impl/flash_sale_repository_impl.dart';
import '../../../domain/repositories/flash_sale_repository.dart';
import '../../../domain/usecases/flash_sale_usecases.dart';

part 'flash_sale_di_providers.g.dart';

// ================================
// DATA LAYER PROVIDERS
// ================================

/// API Service provider
@Riverpod(keepAlive: true)
FlashSaleApiService flashSaleApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return FlashSaleApiService(dio);
}

/// Repository provider
@Riverpod(keepAlive: true)
FlashSaleRepository flashSaleRepository(Ref ref) {
  final apiService = ref.watch(flashSaleApiServiceProvider);
  return FlashSaleRepositoryImpl(apiService);
}

// ================================
// USE CASE PROVIDERS
// ================================

/// Lấy danh sách campaign active
@Riverpod(keepAlive: true)
GetActiveCampaignsUseCase getActiveCampaignsUseCase(Ref ref) {
  final repository = ref.watch(flashSaleRepositoryProvider);
  return GetActiveCampaignsUseCase(repository);
}

/// Lấy danh sách item trong campaign
@Riverpod(keepAlive: true)
GetCampaignItemsUseCase getCampaignItemsUseCase(Ref ref) {
  final repository = ref.watch(flashSaleRepositoryProvider);
  return GetCampaignItemsUseCase(repository);
}
