import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/network/providers/api_provider.dart';
import 'package:delivery_app/features/flash_sale/data/models/flash_sale_model.dart';
import 'package:delivery_app/features/flash_sale/data/repositories/flash_sale_repository.dart';

final flashSaleRepositoryProvider = Provider<FlashSaleRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FlashSaleRepository(apiClient);
});

// Lấy danh sách các campaign đang active
final activeCampaignsProvider = FutureProvider<List<FlashSaleCampaign>>((ref) async {
  final repo = ref.watch(flashSaleRepositoryProvider);
  return repo.getActiveCampaigns();
});

// Lấy danh sách các món ăn trong 1 campaign
final campaignItemsProvider = FutureProvider.family<List<FlashSaleItem>, int>((ref, campaignId) async {
  final repo = ref.watch(flashSaleRepositoryProvider);
  return repo.getCampaignItems(campaignId);
});
