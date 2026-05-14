import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/flash_sale_campaign_entity.dart';
import '../../domain/entities/flash_sale_item_entity.dart';
import '../../domain/usecases/flash_sale_usecases.dart';
import 'di/flash_sale_di_providers.dart';

part 'flash_sale_provider.g.dart';

/// Lấy danh sách các campaign đang active
@riverpod
Future<List<FlashSaleCampaignEntity>> activeCampaigns(Ref ref) async {
  final useCase = ref.watch(getActiveCampaignsUseCaseProvider);
  final result = await useCase(const NoParams());

  return result.fold(
    (failure) => throw failure,
    (campaigns) => campaigns,
  );
}

/// Lấy danh sách các món ăn trong 1 campaign
@riverpod
Future<List<FlashSaleItemEntity>> campaignItems(
  Ref ref,
  int campaignId,
) async {
  final useCase = ref.watch(getCampaignItemsUseCaseProvider);
  final result =
      await useCase(GetCampaignItemsParams(campaignId: campaignId));

  return result.fold(
    (failure) => throw failure,
    (items) => items,
  );
}
